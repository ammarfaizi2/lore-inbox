Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSEQHBX>; Fri, 17 May 2002 03:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSEQHBW>; Fri, 17 May 2002 03:01:22 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:8716 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S315442AbSEQHBV>;
	Fri, 17 May 2002 03:01:21 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205170701.g4H71CB25476@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <200205161635.RAA26824@gw.chygwyn.com> from Steven Whitehouse at
 "May 16, 2002 05:35:43 pm"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Fri, 17 May 2002 09:01:12 +0200 (MET DST)
Cc: ptb@it.uc3m.es, Oliver Xymoron <oxymoron@waste.org>,
        chen xiangping <chen_xiangping@emc.com>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven Whitehouse wrote:"
> Thats effectively what PF_MEMALLOC does. The code in question is in
> page_alloc.c:__alloc_pages just before and after the rebalance: label.
> The z->pages_min gives a per zone minimum for "other processes" that are
> not PF_MEMALLOC,

A related question, then ... can one adjust the difference between the
ceiling for "normal" processes and PF_MEMALLOC processes, and if so,
how?

Peter

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316032AbSEJPnp>; Fri, 10 May 2002 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316037AbSEJPno>; Fri, 10 May 2002 11:43:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316033AbSEJPnA>;
	Fri, 10 May 2002 11:43:00 -0400
Date: Fri, 10 May 2002 08:30:50 -0700 (PDT)
Message-Id: <20020510.083050.55863714.davem@redhat.com>
To: dizzy@roedu.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0205101832080.9661-100000@ahriman.bucharest.roedu.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mihai RUSU <dizzy@roedu.net>
   Date: Fri, 10 May 2002 18:37:21 +0300 (EEST)
   
   PS: why signal(SIGBUS,SIG_IGN) doesnt work, but a user handler its called
   if set with signal(SIGBUS,handle_sigbus) ?

How would you like the kernel to "ignore" a page fault that cannot be
serviced?

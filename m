Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSHLAfg>; Sun, 11 Aug 2002 20:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSHLAfg>; Sun, 11 Aug 2002 20:35:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4247 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318503AbSHLAff>;
	Sun, 11 Aug 2002 20:35:35 -0400
Date: Sun, 11 Aug 2002 17:25:51 -0700 (PDT)
Message-Id: <20020811.172551.89193740.davem@redhat.com>
To: acme@conectiva.com.br
Cc: fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 : net/network.o error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020811224530.GB3890@conectiva.com.br>
References: <Pine.LNX.4.44.0208111252530.11441-100000@localhost.localdomain>
	<20020811224530.GB3890@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 11 Aug 2002 19:45:30 -0300
   
   SMP, these functions are going to die, nowadays they still work on UP, but
   they, AFAIK, will be nuked. In this specific case I have already merged a
   fix with DaveM, wait for 2.5.32 8) They now use BR_NETPROTO_LOCK and use
   the new LLC.

Yes, and this work actually did get pushed to Linus but he dropped
it.  No biggie, I'll repush and we'll hopefully see it in 2.5.32

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRIYQgo>; Tue, 25 Sep 2001 12:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275087AbRIYQgh>; Tue, 25 Sep 2001 12:36:37 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:16912 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S275082AbRIYQg1>; Tue, 25 Sep 2001 12:36:27 -0400
Message-ID: <3BB0B2E0.AA689A97@t-online.de>
Date: Tue, 25 Sep 2001 18:37:52 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do not apply: code for NSC8739x LPC Super I/O chipsets
In-Reply-To: <Pine.LNX.4.31.0109251356290.4391-200000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> 
> Hello,
> 
>         I've attached a patch for NSC8739x LPC Super I/O chipsets to
> enable and configure the parallel port. It would be nice to include this
> code to the official linux kernel tree. Thank you.
> 
>                                                 Jaroslav

Do not apply, there are better much solutions already:

1)
  This chip and much more is already handled (usermode)by:
  http://home.t-online.de/home/gunther.mayer/lssuperio-0.63.tar.gz

2) 
  PNPBIOS is superior at detecting your parallel port !
  I asked the parport maintainer to remove superio from the kernel
  when PNPBIOS makes it into the kernel.

  PNPBIOS is not only a lifesaver on certain laptops (hanging otherwise)
  but too on parallel port configuration which is currently a curse.
  
  Drawback: Alan knows machines with bugs in their pnpbioses.


-
Gunther

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRDWJWa>; Mon, 23 Apr 2001 05:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRDWJWU>; Mon, 23 Apr 2001 05:22:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131638AbRDWJWJ>; Mon, 23 Apr 2001 05:22:09 -0400
Subject: Re: Kernel hang on multi-threaded X process crash
To: manuel@mclure.org (Manuel McLure)
Date: Mon, 23 Apr 2001 10:23:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010422201701.A970@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 22, 2001 08:17:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rcZc-0007di-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Following up on myself, I replaced the contents of /usr/X11R6 server with
> > the standard 4.0.3 RPMs that come with RH 7.1 and it made no difference.
> > Also, if it's important my video card is a Voodoo 5 5500.
> 
> To follow up on my followup, I can now reproduce this 100% and get the
> "Trying to vfree()..." message on the console. To do this I start Mozilla,
> switch to a text console, and do a "killall -QUIT mozilla". A couple of
> "Trying to vfree()..." messages later, it's big red switch time.
> 
> I'm going to try this with standard 2.4.3 as well as the 2.4.2 that comes
> with RH71 - hopefully my filesystem will handle all the fscks :-(

Do you have DRI enabled and if so does disabling DRI help ?

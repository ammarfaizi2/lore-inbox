Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUBOK1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbUBOK1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:27:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:63133 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264446AbUBOK1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:27:05 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1076838882.6957.48.camel@gaston>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <m2znbk4s8j.fsf@p4.localdomain>  <1076838882.6957.48.camel@gaston>
Content-Type: text/plain
Message-Id: <1076840755.6949.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 21:25:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It doesn't seem to work on my x86 laptop. The screen goes black when
> > the framebuffer is enabled early in the boot sequence. The machine
> > boots normally anyway and I can log in from the network or log in
> > blindly at the console. I can then start the X server which appears to
> > work correctly, but switching back to a console still gives me a black
> > screen. Running "setfont" doesn't fix it. Here is what dmesg reports
> > when running 2.6.3-rc3:
> 
> Did it ever work ? (I need to know if it's a regression or some problem
> that was already there in the first place). (Hrm... looking at the end
> of your mail, it indeed seem to be a regression with this version)

BTW. This is the reason I left the "old" driver in, you can still
build it if the new ones goes wrong. 

Ben


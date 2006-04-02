Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWDBWBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWDBWBG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWDBWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:01:05 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:196 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S964791AbWDBWBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:01:04 -0400
Date: Sun, 2 Apr 2006 18:00:47 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       John Livingston <jujutama@comcast.net>,
       "Eric D. Mudama" <edmudama@gmail.com>,
       Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
In-Reply-To: <1144013084.31123.14.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0604021758210.4554-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.04.02.143607
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (2)  It's extremely unlikely that the card itself is faulty; it  
> > exhibits identical symptoms on both drives and has ever since I  
> > originally purchased the card and installed 2.4.X on the system.
> 
> If it has always shown those symptoms then I'd say its quite likely the
> card if the crystals/PLLs on it are out. It looks like the timing is
> wrong, which means either the input clocks (eg PCI clock) are wrong (eg
> 37.5Mhz not 33 due to BIOS overclock settings or just plain out), the
> card has a dodgy crystal/PLL or the kernel set it up wrong.

I mentioned this to Kyle early on, in connection with the idebus=
kernel parameter.  I'm not sure why he wants to believe there's a
software bug causing his problems.


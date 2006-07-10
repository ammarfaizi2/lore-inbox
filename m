Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWGJPBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWGJPBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWGJPBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:01:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5535 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964880AbWGJPBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:01:35 -0400
Subject: Re: [PATCH] Clean up old names in tty code to current names
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
	 <1152539034.27368.124.camel@localhost.localdomain>
	 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
	 <44B26752.9000507@gmail.com>
	 <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 16:19:06 +0100
Message-Id: <1152544746.27368.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 10:57 -0400, ysgrifennodd Jon Smirl:
> > A few apps do rely on /proc/tty/drivers for the major-minor
> > to device name mapping. /dev/vc/0 does not exist (unless
> > created manually) without devfs.
> 
> This is why I questioned if /proc/tty was really in use, it contains
> an entry that is obviously wrong for my system.

Which tools already know about. What is so hard to understand about the
idea that pointless random changes break stuff and don't fix things.

As I've now said three times, put the new stuff in your sysfs work you
are going to submit, and get it right there, then come back and
revisit /proc/tty.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965268AbWGJWO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbWGJWO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWGJWO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:14:26 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:37340 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965268AbWGJWOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:14:24 -0400
Date: Tue, 11 Jul 2006 00:14:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jon Smirl <jonsmirl@gmail.com>
cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
In-Reply-To: <9e4733910607100854x250e9d3aga027ef5e156ec34e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0607110008210.5420@yvahk01.tjqt.qr>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com> 
 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com> 
 <1152537049.27368.119.camel@localhost.localdomain> 
 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com> 
 <1152539034.27368.124.camel@localhost.localdomain> 
 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com> 
 <44B26752.9000507@gmail.com>  <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>
  <1152544746.27368.134.camel@localhost.localdomain>  <44B273B9.8050308@gmail.com>
 <9e4733910607100854x250e9d3aga027ef5e156ec34e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> True.  I see this code snippet many times:
>
> BSD has /dev/vc/0 right? I suspect that code is there to support BSD
> and make the app portable.

$ cd /dev; echo v* z*
v* zero

/dev/vc? Not in FreeBSD 6.1. FreeBSD has ttyv%d, OpenBSD ttyC%d, NetBSD uh I
forgot. In fact, I fail to see an equivalent of tty0 for any BSD. THe next best
thing is /dev/ctty (linux: /dev/tty), but which is something different than
tty0.


Jan Engelhardt
-- 

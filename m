Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTL2CF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 21:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTL2CFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 21:05:34 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:16883 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262328AbTL2CFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 21:05:19 -0500
Message-ID: <18cf01c3cdb0$2ab1cf20$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Peter Osterlund" <petero2@telia.com>
Cc: <linux-kernel@vger.kernel.org>
References: <173901c3cceb$02d68560$43ee4ca5@DIAMONDLX60> <m2pte9cgbu.fsf@telia.com>
Subject: Re: 2.6.0 and mice
Date: Mon, 29 Dec 2003 11:04:14 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund replied to me:

> > 2.  Also in Input device support, there is a section on Mice, PS/2 mouse,
> > and Synaptics TouchPad.  These I compiled in and they don't seem to be
> > causing any problems.  It seems that the Alps TouchPad is being recognized
> > as an Intelli/Wheel mouse instead of being recognized as a Synaptics
> > TouchPad, which is unfortunate but not really causing any problems.  I've
> > read that Synaptics is most common in foreign countries but Alps is most
> > common in Japan.
>
> The synaptics kernel driver doesn't try to recognize alps touchpads.

I guess that explains why the Synaptics driver didn't cause any problems
:-)

> However, in the XFree86 driver
>         http://w1.894.telia.com/~u89404340/touchpad/index.html
> there is a kernel patch (alps.patch) that makes the kernel recognize
> alps touchpads and generate data compatible with the XFree86 synaptics
> driver.

Looking at that page, I'll guess that SuSE 8.2's version of XFree86 probably
already has that patch, because under X the touchpad is performing more than
half of those operations correctly already.

> It doesn't work perfectly though, at least not for some hardware. The
> problem seems to be how to interpret the gesture bit in the alps mouse
> packets.

That's OK, Alps supplies notebook vendors with drivers for Monopolysoft
OSes, and it seems that Alps hasn't completely got this working correctly
either.


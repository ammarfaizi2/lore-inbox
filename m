Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTA1KBM>; Tue, 28 Jan 2003 05:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTA1KBM>; Tue, 28 Jan 2003 05:01:12 -0500
Received: from mail2.webart.de ([195.30.14.11]:21009 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S264944AbTA1KBL>;
	Tue, 28 Jan 2003 05:01:11 -0500
Message-ID: <398E93A81CC5D311901600A0C9F29289469372@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'alexander.riesen@synopsys.COM'" <alexander.riesen@synopsys.COM>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: AW: Bootscreen
Date: Tue, 28 Jan 2003 11:01:15 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> try init=/bin/bash in kernel command line.
Maybe I have a bad aura towards Linux or 
something, but I can *still* press Alt-Fx.

You know, I've thought about the Bootscreen
thingy again, and also had a quick peek (on
Windows here) at those patches.

2.5 is all nice and fluffy, but you shouldn't
use it for any end user software really.

Would it be possible/easy (i.e.: the least
way of resistance) to modify the kernel so
that console initialization does not happen
until everything is up and running? What I
was up to in the first place was getting into
X as fast as possible, and without too many
different screens. I've even been thinking
of setting the hostname, bringing up loop-
back networking and calling xinit directly 
from within the kernel (init/main.c or where
was it?).

So if Linux would not do *anything* to the
screen (as in: just leave alone whatever the 
bootloader put there) just one command before
xinit is called, I'd be the most happy guy
on the planet and you'd see me jump around
in circles :-)

- Raphael 

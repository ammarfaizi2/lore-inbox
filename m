Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131692AbRCUROf>; Wed, 21 Mar 2001 12:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131702AbRCUROZ>; Wed, 21 Mar 2001 12:14:25 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:56041 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131692AbRCUROH>; Wed, 21 Mar 2001 12:14:07 -0500
Date: Wed, 21 Mar 2001 09:13:05 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Tomasz Sterna <smoku@jaszczur.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re:standard_io_resources[]
Message-ID: <Pine.LNX.4.31.0103210908560.2648-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Isn't that a job of the device drivers?

Well most of those resources are present on every PC motherboard.

>In KGI we have our own keyboard driver which tries to allocate the
>kayboard I/O range for itself, and when it does io_check_region() it
>fails. What should I do?

This will also be the case for 2.5.X. We already have the PS/2 keyboard
ported over to the input api. Since we can in theory have a USB system and
then later attach a PS/2 keyboard we have it so the resources are
allocated for PS/2 keyboards.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSABIjH>; Wed, 2 Jan 2002 03:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286780AbSABIi5>; Wed, 2 Jan 2002 03:38:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47112 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286779AbSABIii>; Wed, 2 Jan 2002 03:38:38 -0500
Subject: Re: [RFC] Embedded X86 systems Was: [PATCH][RFC] AMD Elan patch
To: wingel@t1.ctrl-c.liu.se
Date: Wed, 2 Jan 2002 08:45:25 +0000 (GMT)
Cc: hpa@zytor.com, robert@schwebel.de, linux-kernel@vger.kernel.org,
        jason@mugwump.taiga.com, anders@alarsen.net, rkaiser@sysgo.de
In-Reply-To: <20020102010727.E0BEC36F9F@hog.ctrl-c.liu.se> from "Christer Weinigel" at Jan 02, 2002 02:07:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Lh1Z-0003Go-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is the basic Cx5530 chipset, which could have support in the
> Linux kernel (IDE, graphics and sound).

It already does. Has done for ages. The non SB emulation mode of the audio
is not supported but that I don't think matters.

> for all chips, some are specific for a variant, such as the video
> input port and graphics overlay/genlock.

X11

In general if we want to support lots of weird crap then the ARM folks have
a very nice model and a lot of weird crap to have developed their ideas
against. Personal preference

	Type of system	(PC, Embedded)

then for PC leave as is, for embedded
	
	Board type (blah, blah , blah)
	Firmware (PC BIOS, LinuxBIOS, RedBoot)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288105AbSACAwe>; Wed, 2 Jan 2002 19:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288095AbSACAu5>; Wed, 2 Jan 2002 19:50:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:785 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288087AbSACAuZ>; Wed, 2 Jan 2002 19:50:25 -0500
Subject: Re: Strange USB issues... - 2.4.x Kernels & more info
To: spstarr@sh0n.net (Shawn Starr)
Date: Thu, 3 Jan 2002 01:00:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1010018353.20263.15.camel@unaropia> from "Shawn Starr" at Jan 02, 2002 07:38:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LwFY-0006Ja-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
> in. I get:
> 
> 1) Slow loading of kernel into memory on bootup
> 2) AT keyboard timeout (?) errors and no activity with the keyboard
> (shift lock/numlock/scroll lock). I  have to reboot to correct the
> problem by disabling USB in the bios.

Buggy BIOS SMM emulation of PS/2 keyboard and mouse on the USB port.

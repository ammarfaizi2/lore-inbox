Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUALMLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUALMLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:11:51 -0500
Received: from aun.it.uu.se ([130.238.12.36]:12239 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266150AbUALMLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:11:49 -0500
Date: Mon, 12 Jan 2004 13:11:42 +0100 (MET)
Message-Id: <200401121211.i0CCBg5u006677@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, raul@pleyades.net
Subject: Re: SMP or UP???
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004 11:20:39 +0100, DervishD <raul@pleyades.net> wrote:
>    I have an used Gigabyte GA-7ZXE mobo, with chipset VIA KT133A,
>wearing a Duron 1000 processor, since December. AFAIK this mobo is
>uniprocessor (it has only a socket, that should be a good
>evidence...), but when booting I get these messages (I just show
>those relevant to the issue):
>
>kernel: Linux version 2.4.21 (root@DervishD) (gcc version 3.2.2) #1 Wed Jul 2 17:25:21 CEST 2003
>kernel: found SMP MP-table at 000fb210
>
>    What, SMP table?
...
>    This is not an issue, because the system seems to work OK, but
>for me is very strange and I'm not sure wether this may cause
>problems or not...

You have an anti-problem. The chipset includes an I/O-APIC
(good) and your mobo manufacturer was decent enough to include
the appropriate BIOS MP tables to describe it to the OS.

Other manufacturers skip the MP table, forcing you to enable
ACPI and pray it actually works. 

This is one area where Gigabyte seems to be consistently
better (more user-friendly) than ASUS.

/Mikael

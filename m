Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265303AbRF2BpJ>; Thu, 28 Jun 2001 21:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265314AbRF2BpA>; Thu, 28 Jun 2001 21:45:00 -0400
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:14554 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S265303AbRF2Bo5>; Thu, 28 Jun 2001 21:44:57 -0400
Date: Thu, 28 Jun 2001 21:46:49 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: Alan Cox <laughing@shared-source.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac21
In-Reply-To: <20010629005133.A30356@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0106282143240.19421-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.5-ac21
> o	Fix pnpbios compile failure and add docking	(me)
> 	station hotplug (/sbin/hotplug dock)

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -DEXPORT_SYMTAB -c pnp_bios.c
pnp_bios.c: In function `pnp_dock_event':
pnp_bios.c:442: `hotplug_path' undeclared (first use in this function)
pnp_bios.c:442: (Each undeclared identifier is reported only once
pnp_bios.c:442: for each function it appears in.)
pnp_bios.c: In function `pnp_dock_thread':
pnp_bios.c:496: warning: `d' might be used uninitialized in this function
pnp_bios.c: At top level:
pnp_bios.c:597: warning: `pnp_bios_exit' defined but not used
{standard input}: Assembler messages:
{standard input}:64: Warning: indirect lcall without `*'
{standard input}:135: Warning: indirect lcall without `*'
{standard input}:188: Warning: indirect lcall without `*'
{standard input}:229: Warning: indirect lcall without `*'
make[3]: *** [pnp_bios.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/pnp'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/pnp'
make[1]: *** [_subdir_pnp] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

I'm using gcc-2.95.6 (Mandrake 8.0) and binutils 2.10.1.0.2.

-- 
Garett


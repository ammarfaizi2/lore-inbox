Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHNWnr>; Wed, 14 Aug 2002 18:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSHNWnr>; Wed, 14 Aug 2002 18:43:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56526 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315779AbSHNWnp>; Wed, 14 Aug 2002 18:43:45 -0400
Date: Thu, 15 Aug 2002 00:47:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
In-Reply-To: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208150036100.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Alan Cox wrote:

>...
> Linux 2.4.20-pre1-ac3
>...
> +	Merge synclink-mp driver			(Paul Fulghum)
>...

cuamajor should be renamed to avoid the following compile error:

<--  snip  -->

...
ld -m elf_i386  -r -o char.o mem.o tty_io.o n_tty.o tty_ioctl.o raw.o
pty.o misc.o random.o vt.o vc_screen.o consolemap.o consolemap_deftbl.o
console.o selection.o serial.o keyboard.o defkeymap.o pc_keyb.o sysrq.o
rocket.o mxser.o moxa.o epca.o cyclades.o stallion.o istallion.o ip2.o
ip2main.o riscom8.o esp.o synclink.o synclinkmp.o n_hdlc.o specialix.o
sx.o generic_serial.o rio/rio.o atixlmouse.o logibusmouse.o lp.o
joystick/js.o busmouse.o dtlk.o n_r3964.o applicom.o sonypi.o msbusmouse.o
qpmouse.o pc110pad.o mk712.o rtc.o nvram.o toshiba.o i8k.o i810_rng.o
amd768_rng.o amd76x_pm.o tpqic02.o ftape/ftape.o ppdev.o pcwd.o
acquirewdt.o advantechwdt.o ib700wdt.o mixcomwd.o sbc60xxwdt.o
w83877f_wdt.o sc520_wdt.o wdt.o wdt_pci.o i810-tco.o machzwd.o
eurotechwdt.o alim7101_wdt.o alim1535d_wdt.o sc1200wdt.o wafer5823wdt.o
softdog.o amd7xx_tco.o mwave/mwave.o
synclinkmp.o(.data+0x34): multiple definition of `cuamajor'
synclink.o(.bss+0x10): first defined here
make[3]: *** [char.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/char'

<--  snip  -->

cu
Adrian


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSHPMZK>; Fri, 16 Aug 2002 08:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318333AbSHPMZJ>; Fri, 16 Aug 2002 08:25:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12015 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318332AbSHPMZJ>; Fri, 16 Aug 2002 08:25:09 -0400
Date: Fri, 16 Aug 2002 14:29:02 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <200208151918.g7FJI6J04061@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208161427560.6334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

The following compile error is still present in 2.4.20-pre2-ac3:

<--  snip  -->

...
ld -m elf_i386  -r -o char.o mem.o tty_io.o n_tty.o tty_ioctl.o raw.o
pty.o misc.o random.o vt.o vc_screen.o consolemap.o consolemap_deftbl.o
console.o selection.o serial.o keyboard.o speakup/speakupmap.o pc_keyb.o
sysrq.o rocket.o mxser.o moxa.o epca.o cyclades.o stallion.o istallion.o
ip2.o ip2main.o riscom8.o esp.o synclink.o synclinkmp.o n_hdlc.o
specialix.o sx.o generic_serial.o rio/rio.o atixlmouse.o logibusmouse.o
lp.o joystick/js.o busmouse.o dtlk.o n_r3964.o applicom.o sonypi.o
msbusmouse.o qpmouse.o pc110pad.o mk712.o rtc.o nvram.o toshiba.o i8k.o
i810_rng.o amd768_rng.o amd76x_pm.o tpqic02.o ftape/ftape.o speakup/spk.o
ppdev.o pcwd.o acquirewdt.o advantechwdt.o ib700wdt.o mixcomwd.o
sbc60xxwdt.o w83877f_wdt.o sc520_wdt.o wdt.o wdt_pci.o i810-tco.o
machzwd.o eurotechwdt.o alim7101_wdt.o alim1535d_wdt.o sc1200wdt.o
wafer5823wdt.o softdog.o amd7xx_tco.o mwave/mwave.o
speakup/spk.o(.data+0xad80): multiple definition of `ctrl_map'
speakup/speakupmap.o(.data+0x300): first defined here
speakup/spk.o(.data+0xac80): multiple definition of `altgr_map'
speakup/speakupmap.o(.data+0x200): first defined here
...
make[3]: *** [char.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/char'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJBSw>; Tue, 9 Jan 2001 20:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRAJBSo>; Tue, 9 Jan 2001 20:18:44 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:28422 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129431AbRAJBSb>;
	Tue, 9 Jan 2001 20:18:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] linux-kernel v2.0.39 
In-Reply-To: Your message of "Wed, 10 Jan 2001 10:27:44 +1100."
             <3A5B9E70.DF89B978@eyal.emu.id.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 12:18:14 +1100
Message-ID: <23111.979089494@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001 10:27:44 +1100, 
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>My 'make dep' fails in the following way. This is on Debian 2.2, I
>commented
>if [ -n "amigamouse.c atarimouse.c atixlmouse.c baycom.c busmouse.c
>cd1865.h conmakehash.c console.c console_struct.h consolemap.c
>consolemap.h cyclades.c defkeymap.c diacr.h digi.h digi_bios.h
>digi_fep.h fbmem.c fep.h h8.c h8.h isicom.c istallion.c kbd_kern.h
>keyb_m68k.c keyboard.c lp.c lp_intern.c lp_m68k.c mem.c misc.c
>msbusmouse.c n_tty.c pcwd.c pcxx.c pcxx.h psaux.c pty.c random.c
>riscom8.c riscom8.h riscom8_reg.h rtc.c scc.c selection.c selection.h
>serial.c softdog.c specialix.c specialix_io8.h stallion.c tga.c
>tpqic02.c tty_io.c tty_ioctl.c vc_screen.c vesa_blank.c vga.c vt.c
>vt_kern.h wd501p.h wdt.c" ]; then \
>/usr/local/src/linux/scripts/mkdep *.[chS] > .depend; fi
>make[2]: *** [fastdep] Error 135

135 == 128+7 => E2BIG (Arg list too long).  What does
  ls -l /usr/local/src/linux/drivers/char/*.[chS] | wc
report?  And which kernel/libc are you compiling on?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

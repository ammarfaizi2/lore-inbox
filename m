Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318367AbSGYHRw>; Thu, 25 Jul 2002 03:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318368AbSGYHRw>; Thu, 25 Jul 2002 03:17:52 -0400
Received: from www.transvirtual.com ([206.14.214.140]:39942 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318367AbSGYHRv>; Thu, 25 Jul 2002 03:17:51 -0400
Date: Thu, 25 Jul 2002 00:20:51 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] console changes part 2
Message-ID: <Pine.LNX.4.44.0207250019330.29650-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Okay here is a updated patch aginst Linus latest tree.


http://www.transvirtual.com/~jsimmons/console.diff.gz

http://linuxconsole.bkbits.net:8080/dev

diffstat

 arch/i386/boot/compressed/vmlinux.bin.gz |binary
 arch/mips/au1000/common/serial.c         |    2
 arch/ppc/4xx_io/serial_sicc.c            |    2
 arch/ppc/8xx_io/uart.c                   |    2
 drivers/char/Makefile                    |   12
 drivers/char/console.c                   | 3032 -----
 drivers/char/console_macros.h            |  155
 drivers/char/consolemap.c                |  121
 drivers/char/hvc_console.c               |    2
 drivers/char/keyboard.c                  |  583 -
 drivers/char/misc.c                      |    1
 drivers/char/selection.c                 |   21
 drivers/char/serial_amba.c               |    2
 drivers/char/sysrq.c                     |   16
 drivers/char/tty_io.c                    |    2
 drivers/char/vc_screen.c                 |  105
 drivers/char/vt.c                        | 4855 +++++++--
 drivers/char/vt_ioctl.c                  | 1357 ++
 drivers/s390/char/ctrlchar.c             |    2
 drivers/sbus/char/sunkbd.c               |    2
 drivers/tc/zs.c                          |    2
 drivers/video/dummycon.c                 |    1
 drivers/video/fbcon-accel.c              |    5
 drivers/video/fbcon.c                    |   10
 drivers/video/mdacon.c                   |    3
 drivers/video/newport_con.c              |    1
 drivers/video/promcon.c                  |   23
 drivers/video/sticon.c                   |    1
 drivers/video/vgacon.c                   |    1
 include/linux/console.h                  |   17
 include/linux/console_struct.h           |  110
 include/linux/consolemap.h               |    6
 include/linux/kbd_kern.h                 |   26
 include/linux/selection.h                |   24
 include/linux/tty.h                      |    2
 include/linux/vt_kern.h                  |  172
 include/video/fbcon.h                    |    2
 scripts/fixdep                           |binary
 40 files changed, 25467 insertions(+), 4756 deletions(-)

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317266AbSGCW4W>; Wed, 3 Jul 2002 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSGCW4V>; Wed, 3 Jul 2002 18:56:21 -0400
Received: from www.transvirtual.com ([206.14.214.140]:56591 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317266AbSGCW4V>; Wed, 3 Jul 2002 18:56:21 -0400
Date: Wed, 3 Jul 2002 15:58:45 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] Console/tty system patch. II
Message-ID: <Pine.LNX.4.44.0207031556140.26377-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I fixed that bug with VT switching. Give the new patch a try so I can push
it to Linus. Thanks!!

BK:
	http://linuxconsole.bkbits.net:8080/dev

diff:
	http://www.transvirtual.com/~jsimmons/console.diff.gz

diffstat:

 arch/i386/kernel/apm.c         |    2
 arch/ppc/xmon/start.c          |    2
 arch/ppc64/xmon/start.c        |    2
 drivers/acpi/system.c          |    2
 drivers/char/console.c         |   82 ++--
 drivers/char/keyboard.c        |  781 +++++++++++++++++++++--------------------
 drivers/char/sysrq.c           |   46 +-
 drivers/char/tty_io.c          |   15
 include/linux/console_struct.h |    1
 include/linux/sysrq.h          |   13
 11 files changed, 487 insertions(+), 459 deletions(-)

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbRF2Q0v>; Fri, 29 Jun 2001 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbRF2Q0l>; Fri, 29 Jun 2001 12:26:41 -0400
Received: from max1-69.flint.corecomm.net ([208.40.12.69]:19720 "HELO
	fire-eyes.yi.org") by vger.kernel.org with SMTP id <S266113AbRF2Q0W>;
	Fri, 29 Jun 2001 12:26:22 -0400
Date: Fri, 29 Jun 2001 12:26:18 -0400 (EDT)
From: sgtphou <sgtphou@fire-eyes.yi.org>
To: <mec@shout.net>
cc: <linux-kernel@vger.kernel.org>
Subject: 2.4.5-ac21: make menuconfig errors
Message-ID: <Pine.LNX.4.30.0106291218200.6225-100000@fire-eyes>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to configure 2.4.5-ac21 when I ran into some problems. First
off i noticed this when I went to make menuconfig :

root@fire-eyes:/usr/src/linux # make menuconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts/lxdialog all
make[1]: Entering directory `/usr/src/linux-2.4.5-ac21/scripts/lxdialog'
make[1]: Leaving directory `/usr/src/linux-2.4.5-ac21/scripts/lxdialog'
/bin/sh scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions,
parsing..........................scripts/Menuconfig: ./MCmenu31: line 185:
syntax error near unexpected token `fi'
scripts/Menuconfig: ./MCmenu31: line 185: `fi'
...............make: *** [menuconfig] Error 1

The Error at the end is ONLY BECAUSE I ^c to see the line 185 error,
otherwise the menu would have popped up and covered it up.

AFter this the menu comes up.

And here is another problem ..

Network device support  --->
	Ethernet (10 or 100Mbit)  --->

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu31: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1


 I simply skipped that menu, and now I am attempting to continue with the
kernel build. I would state here if that failed or not but this is a slow
system.

I am not on the list, I would appreciate anything important being mailed
to me. Or if I get sub instructions back ill sub.


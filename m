Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263054AbSJBLr2>; Wed, 2 Oct 2002 07:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbSJBLr2>; Wed, 2 Oct 2002 07:47:28 -0400
Received: from fep02.tuttopmi.it ([212.131.248.101]:39399 "EHLO
	fep02-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S263054AbSJBLr1> convert rfc822-to-8bit; Wed, 2 Oct 2002 07:47:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: mec@shout.net
Subject: 2.5.40: make menuconfig error
Date: Wed, 2 Oct 2002 14:03:00 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210021403.00305.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me because I'm not in the list
Here it is:


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1


Another strangeness: Some drivers do not build and finding the errors is 
difficult because the error messages come only during linking. When I build 
the kernel usually run this command:

make (bzImage | modules) 2> /some/file .

During compiling i haven't get any compile error, this seems as the linker 
goes searching for files not compiled:

ld: cannot open ircomm_tty.o: No such file or directory
make[3]: *** [ircomm-tty.o] Error 1
make[2]: *** [ircomm] Error 2
make[1]: *** [irda] Error 2
make: *** [net] Error 2


Cheers,
Frederik Nosi


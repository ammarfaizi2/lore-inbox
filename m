Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268567AbTANDri>; Mon, 13 Jan 2003 22:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268569AbTANDri>; Mon, 13 Jan 2003 22:47:38 -0500
Received: from visp12-175.visp.co.nz ([210.54.175.12]:13831 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id <S268567AbTANDrf>;
	Mon, 13 Jan 2003 22:47:35 -0500
Subject: drivers/char/Kconfig:640: can't open file
	"drivers/char/ipmi/Kconfig"
From: mdew <mdew@mdew.dyndns.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Jan 2003 16:56:20 +1300
Message-Id: <1042516580.26487.9.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from a bk-pull today,


nirvana:/usr/src/mylinux-2.5# make xconfig
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/qconf
  cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer   -c -o scripts/kconfig/conf.o
scripts/kconfig/conf.c
sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h
's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
  gcc -Wp,-MD,scripts/kconfig/.kconfig_load.o.d -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o
scripts/kconfig/kconfig_load.o scripts/kconfig/kconfig_load.c
  gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer   -c -o scripts/kconfig/mconf.o
scripts/kconfig/mconf.c
/opt/qt//bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf.moc
  g++ -Wp,-MD,scripts/kconfig/.qconf.o.d -O2  -I/opt/qt//include  -c -o
scripts/kconfig/qconf.o scripts/kconfig/qconf.cc
  cat scripts/kconfig/zconf.tab.c_shipped > scripts/kconfig/zconf.tab.c
  cat scripts/kconfig/lex.zconf.c_shipped > scripts/kconfig/lex.zconf.c
  gcc -Wp,-MD,scripts/kconfig/.zconf.tab.o.d -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer  -Iscripts/kconfig -fPIC -c -o
scripts/kconfig/zconf.tab.o scripts/kconfig/zconf.tab.c
  gcc  -shared -o scripts/kconfig/libkconfig.so
scripts/kconfig/zconf.tab.o
  g++  -o scripts/kconfig/qconf  scripts/kconfig/kconfig_load.o 
scripts/kconfig/qconf.o  -L/opt/qt//lib -Wl,-rpath,/opt/qt//lib -lqt-mt
-ldl
./scripts/kconfig/qconf arch/i386/Kconfig
Xlib:  extension "GLX" missing on display ":0.0".
Xlib:  extension "GLX" missing on display ":0.0".
drivers/char/Kconfig:640: can't open file "drivers/char/ipmi/Kconfig"
make: *** [xconfig] Error 1
nirvana:/usr/src/mylinux-2.5# make oldconfig
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/conf
  gcc  -o scripts/kconfig/conf scripts/kconfig/conf.o
scripts/kconfig/libkconfig.so
./scripts/kconfig/conf -o arch/i386/Kconfig
drivers/char/Kconfig:640: can't open file "drivers/char/ipmi/Kconfig"
make: *** [oldconfig] Error 1





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268197AbTALCQn>; Sat, 11 Jan 2003 21:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268200AbTALCQn>; Sat, 11 Jan 2003 21:16:43 -0500
Received: from services.cam.org ([198.73.180.252]:5287 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S268197AbTALCQm> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 21:16:42 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: make xconfig broken in bk current
Date: Sat, 11 Jan 2003 21:25:49 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Message-Id: <200301112125.49418.tomlins@cam.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get

make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/qconf
  g++  -o scripts/kconfig/qconf  scripts/kconfig/kconfig_load.o  scripts/kconfig/qconf.o  -L/usr/share
/qt/lib -Wl,-rpath,/usr/share/qt/lib -lqt-mt -ldl
scripts/kconfig/qconf.o(.text+0x31): In function `ConfigView::tr(char const*, char const*)':
: undefined reference to `QApplication::translate(char const*, char const*, char const*, QApplication:
:Encoding) const'
..
..
along with many more error doing:
make xconfig 
in bk current.

Ideas
Ed Tomlison

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSKGWsF>; Thu, 7 Nov 2002 17:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266642AbSKGWrq>; Thu, 7 Nov 2002 17:47:46 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:6663 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266640AbSKGWrm>; Thu, 7 Nov 2002 17:47:42 -0500
Date: Thu, 7 Nov 2002 23:54:19 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: kconfig updates
Message-ID: <Pine.LNX.4.44.0211072346420.13258-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just sent various kconfig updates to Linus. The patches can be found at 
http://www.xs4all.nl/~zippel/lc/patches/
Several small fixes for the reported problems, Petr's single menu mode for 
menuconfig, Documentation update, removal of the old config tools and 
update of the MAINTAINER entry.

bye, Roman

 CREDITS                                   |    4 
 Documentation/DocBook/kernel-hacking.tmpl |    2 
 Documentation/kbuild/00-INDEX             |    4 
 Documentation/kbuild/config-language.txt  |  706 ------------
 Documentation/kbuild/kconfig-language.txt |  255 ++++
 MAINTAINERS                               |   13 
 Makefile                                  |    1 
 arch/alpha/Kconfig                        |    2 
 arch/arm/Kconfig                          |    2 
 arch/i386/Kconfig                         |    2 
 arch/m68k/Kconfig                         |    2 
 arch/m68knommu/Kconfig                    |    2 
 arch/mips/Kconfig                         |    2 
 arch/mips64/Kconfig                       |    2 
 arch/ppc/Kconfig                          |    2 
 arch/ppc64/Kconfig                        |    2 
 arch/s390/Kconfig                         |    2 
 arch/s390x/Kconfig                        |    2 
 arch/sh/Kconfig                           |    2 
 arch/sparc/Kconfig                        |    2 
 arch/v850/Kconfig                         |    2 
 arch/x86_64/Kconfig                       |    2 
 drivers/parport/Kconfig                   |    2 
 scripts/Configure                         |  688 -----------
 scripts/Makefile                          |   28 
 scripts/Menuconfig                        | 1469 -------------------------
 scripts/README.Menuconfig                 |   19 
 scripts/kconfig/conf.c                    |    3 
 scripts/kconfig/confdata.c                |   27 
 scripts/kconfig/expr.h                    |    2 
 scripts/kconfig/lex.zconf.c_shipped       |  418 +++----
 scripts/kconfig/mconf.c                   |   67 -
 scripts/kconfig/menu.c                    |    2 
 scripts/kconfig/qconf.cc                  |   38 
 scripts/kconfig/zconf.l                   |   39 
 scripts/kconfig/zconf.tab.c_shipped       | 1749 ++++++++++++++++--------------
 scripts/kconfig/zconf.tab.h_shipped       |  146 +-
 scripts/tail.tk                           |   89 -
 scripts/tkcond.c                          |  602 ----------
 scripts/tkgen.c                           | 1521 --------------------------
 scripts/tkparse.c                         |  828 --------------
 scripts/tkparse.h                         |  127 --
 42 files changed, 1713 insertions(+), 7166 deletions(-)



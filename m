Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTALRjt>; Sun, 12 Jan 2003 12:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTALRjt>; Sun, 12 Jan 2003 12:39:49 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:26641 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267345AbTALRjt>; Sun, 12 Jan 2003 12:39:49 -0500
Message-ID: <3E217477.6B8E3758@linux-m68k.org>
Date: Sun, 12 Jan 2003 14:58:15 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: make xconfig broken in bk current
References: <200301112125.49418.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ed Tomlinson wrote:

> make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/qconf
>   g++  -o scripts/kconfig/qconf  scripts/kconfig/kconfig_load.o  scripts/kconfig/qconf.o  -L/usr/share
> /qt/lib -Wl,-rpath,/usr/share/qt/lib -lqt-mt -ldl
> scripts/kconfig/qconf.o(.text+0x31): In function `ConfigView::tr(char const*, char const*)':
> : undefined reference to `QApplication::translate(char const*, char const*, char const*, QApplication:
> :Encoding) const'

Which distribution do you use?
It looks like you try to use a different g++ version than qt was
compiled with.

bye, Roman



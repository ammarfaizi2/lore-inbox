Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSKRVKt>; Mon, 18 Nov 2002 16:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSKRVKt>; Mon, 18 Nov 2002 16:10:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18940 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264818AbSKRVKr>;
	Mon, 18 Nov 2002 16:10:47 -0500
Message-ID: <3DD958DA.9F26261B@mvista.com>
Date: Mon, 18 Nov 2002 13:17:14 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.5.48 xconfig issue
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And after I spend ?? hours loading qt... :(


[george@data 2.5.48-hrp]$ build xconfig
i386
CROSS_COMPILE=/usr/src/hardhat/devkit/x86/pentium3/bin/pentium3-
nice -10 make xconfig
  g++ -Wp,-MD,scripts/kconfig/.qconf.o.d -O2 
-I/usr/src/incoming/qt/qt-x11-free-3.0.6/include  -c -o
scripts/kconfig/qconf.o scripts/kconfig/qconf.cc
In file included from scripts/kconfig/qconf.cc:29:
scripts/kconfig/qconf.moc:36: syntax error before `('
scripts/kconfig/qconf.moc:41: no `void
ConfigList::initMetaObject()' member function declared in
class `ConfigList'
scripts/kconfig/qconf.moc: In method `void
ConfigList::initMetaObject()':
scripts/kconfig/qconf.moc:45: warning: implicit declaration
of function `int badSuperclassWarning(...)'
scripts/kconfig/qconf.moc: At top level:
scripts/kconfig/qconf.moc:52: prototype for `class QString
ConfigList::tr(const char *)' does not match any in class
`ConfigList'
scripts/kconfig/qconf.h:20: candidate is: static class
QString ConfigList::tr(const char *, const char * = 0)
scripts/kconfig/qconf.moc: In method `class QString
ConfigList::tr(const char *)':
scripts/kconfig/qconf.moc:53: `QNonBaseApplication'
undeclared (first use this function)
scripts/kconfig/qconf.moc:53: (Each undeclared identifier is
reported only once
scripts/kconfig/qconf.moc:53: for each function it appears
in.)
scripts/kconfig/qconf.moc:53: parse error before `)'
scripts/kconfig/qconf.moc: At top level:
scripts/kconfig/qconf.moc:57: new declaration `static void
ConfigList::staticMetaObject()'
scripts/kconfig/qconf.h:20: ambiguates old declaration
`static class QMetaObject * ConfigList::staticMetaObject()'
scripts/kconfig/qconf.moc: In function `static void
ConfigList::staticMetaObject()':
scripts/kconfig/qconf.moc:76: no method
`QMetaObject::new_metadata'
scripts/kconfig/qconf.moc:82: `struct QMetaData' has no
member named `ptr'
scripts/kconfig/qconf.moc:82: `QMember' undeclared (first
use this function)
scripts/kconfig/qconf.moc:82: parse error before `)'
scripts/kconfig/qconf.moc:83: `struct QMetaData' has no
member named `ptr'
scripts/kconfig/qconf.moc:83: confused by earlier errors,
bailing out
make[1]: *** [scripts/kconfig/qconf.o] Error 1
make: *** [scripts/kconfig/qconf] Error 2

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

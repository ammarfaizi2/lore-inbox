Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311274AbSCVJRD>; Fri, 22 Mar 2002 04:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311396AbSCVJQy>; Fri, 22 Mar 2002 04:16:54 -0500
Received: from [203.197.61.74] ([203.197.61.74]:62853 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S311274AbSCVJQm>; Fri, 22 Mar 2002 04:16:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Vinolin <vinolin@nodeinfotech.com>
To: linux-kernel@vger.kernel.org
Subject: KDE crash handler ( X windows )
Date: Fri, 22 Mar 2002 14:49:01 +0530
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02032214490100.00900@Vinolin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

When i try to open KDE konqueror browser, KDE crash handler showed me the 
following ,

(no debugging symbols found)...0x40e1e519 in __wait4 ()
   from /lib/i686/libc.so.6
#0  0x40e1e519 in __wait4 () from /lib/i686/libc.so.6
#1  0x40e8e9e4 in __DTOR_END__ () from /lib/i686/libc.so.6
#2  0x4061c998 in KCrash::defaultCrashHandler () at eval.c:41
#3  <signal handler called>
#4  0x40d91801 in __kill () from /lib/i686/libc.so.6
#5  0x40d915da in raise (sig=6) at ../sysdeps/posix/raise.c:27
#6  0x40d92d82 in abort () at ../sysdeps/generic/abort.c:88
#7  0x40d1ff2b in __default_terminate () at ../../gcc/libgcc2.c:3034
#8  0x40d1ff4a in __terminate () at ../../gcc/libgcc2.c:3034
#9  0x40d20c9a in throw_helper (eh=0x40d3dbc0, pc=0x4061f8fd, 
    my_udata=0xbfffe8b0, offset_p=0xbfffe8ac) at ../../gcc/libgcc2.c:3168
#10 0x40d20f4f in __rethrow (index=0x40d3b058) at ../../gcc/libgcc2.c:3168
#11 0x40d230cf in __builtin_vec_new (sz=3901627402)
   from /usr/lib/libstdc++-libc6.2-2.so.3
#12 0x4061f8fe in KURL::parse () at eval.c:41
#13 0x4065f3f1 in KURL::operator= () at eval.c:41
#14 0x4010f9f9 in operator>> () at eval.c:41
#15 0x4010ab0a in KonqHistoryManager::loadHistory () at eval.c:41
#16 0x4010a456 in KonqHistoryManager::KonqHistoryManager () at eval.c:41
#17 0x40041615 in KonqMainWindow::KonqMainWindow () at eval.c:41
#18 0x40078161 in KonqMisc::createBrowserWindowFromProfile () at eval.c:41
#19 0x40078046 in KonqMisc::createNewWindow () at eval.c:41
#20 0x4003f2d8 in main () at eval.c:41
#21 0x40d80177 in __libc_start_main (main=0x804855c <main>, argc=2, 
    ubp_av=0xbffff8f4, init=0x8048524 <_init>, fini=0x80486dc <_fini>, 
    rtld_fini=0x4000e184 <_dl_fini>, stack_end=0xbffff8ec)
    at ../sysdeps/generic/libc-start.c:129

When i try to open home directory folder, KDE crash handler showed me the 
following ,

(no debugging symbols found)...(no debugging symbols found)...
(no debugging symbols found)...0x40d06519 in __wait4 ()
   from /lib/i686/libc.so.6
#0  0x40d06519 in __wait4 () from /lib/i686/libc.so.6
#1  0x40d769e4 in __DTOR_END__ () from /lib/i686/libc.so.6
#2  0x40528998 in KCrash::defaultCrashHandler () at eval.c:41
#3  <signal handler called>
#4  0x40c79801 in __kill () from /lib/i686/libc.so.6
#5  0x40c795da in raise (sig=6) at ../sysdeps/posix/raise.c:27
#6  0x40c7ad82 in abort () at ../sysdeps/generic/abort.c:88
#7  0x40c05f2b in __default_terminate () at ../../gcc/libgcc2.c:3034
#8  0x40c05f4a in __terminate () at ../../gcc/libgcc2.c:3034
#9  0x40c06c9a in throw_helper (eh=0x40c23bc0, pc=0x4052b8fd, 
    my_udata=0xbfffd490, offset_p=0xbfffd48c) at ../../gcc/libgcc2.c:3168
#10 0x40c06f4f in __rethrow (index=0x40c21058) at ../../gcc/libgcc2.c:3168
#11 0x40c090cf in __builtin_vec_new (sz=3901627402)
   from /usr/lib/libstdc++-libc6.2-2.so.3
#12 0x4052b8fe in KURL::parse () at eval.c:41
#13 0x4056b3f1 in KURL::operator= () at eval.c:41
#14 0x412139f9 in operator>> () from /usr/lib/libkonq.so.3

#15 0x4120eb0a in KonqHistoryManager::loadHistory () from 
/usr/lib/libkonq.so.3

#16 0x4120e456 in KonqHistoryManager::KonqHistoryManager ()
   from /usr/lib/libkonq.so.3
#17 0x41145615 in KonqMainWindow::KonqMainWindow () from /usr/lib/konqueror.so

#18 0x4117c161 in KonqMisc::createBrowserWindowFromProfile ()
   from /usr/lib/konqueror.so
#19 0x4114368e in KonquerorIface::createBrowserWindowFromProfile ()
   from /usr/lib/konqueror.so
#20 0x4118b4fb in KonquerorIface::process () from /usr/lib/konqueror.so
#21 0x4002f4a4 in DCOPClient::receive () at eval.c:41
#22 0x40021920 in DCOPProcessInternal () at eval.c:41
#23 0x400214cf in DCOPProcessMessage () at eval.c:41
#24 0x40bd2b4a in IceProcessMessages () from /usr/X11R6/lib/libICE.so.6
#25 0x400358d0 in DCOPClient::processSocketData () at eval.c:41
#26 0x4077a011 in QObject::activate_signal ()
   from /usr/lib/qt-2.3.0/lib/libqt.so.2
#27 0x407d18b6 in QSocketNotifier::activated ()
   from /usr/lib/qt-2.3.0/lib/libqt.so.2
#28 0x407af2d7 in QSocketNotifier::event ()
   from /usr/lib/qt-2.3.0/lib/libqt.so.2

#29 0x40722154 in QApplication::notify () from 
/usr/lib/qt-2.3.0/lib/libqt.so.2

#30 0x404cf019 in KApplication::notify () at eval.c:41
#31 0x406ed34b in sn_activate () from /usr/lib/qt-2.3.0/lib/libqt.so.2
#32 0x406edbbf in QApplication::processNextEvent ()
   from /usr/lib/qt-2.3.0/lib/libqt.so.2
#33 0x40723fec in QApplication::enter_loop ()
   from /usr/lib/qt-2.3.0/lib/libqt.so.2
#34 0x406ed3b7 in QApplication::exec () from /usr/lib/qt-2.3.0/lib/libqt.so.2
#35 0x41143340 in main () from /usr/lib/konqueror.so
#36 0x0804a49b in strcpy () at ../sysdeps/generic/strcpy.c:31
#37 0x0804add1 in strcpy () at ../sysdeps/generic/strcpy.c:31
#38 0x0804b2a6 in strcpy () at ../sysdeps/generic/strcpy.c:31
#39 0x0804bff1 in strcpy () at ../sysdeps/generic/strcpy.c:31
#40 0x40c68177 in __libc_start_main (main=0x804bc20 <strcpy+7972>, argc=2, 
    ubp_av=0xbffffad4, init=0x8049764 <_init>, fini=0x804c460 <_fini>, 
    rtld_fini=0x4000e184 <_dl_fini>, stack_end=0xbffffacc)
    at ../sysdeps/generic/libc-start.c:129

Can anyone help me to findout the bug ....?

Thank you,

Vinolin.





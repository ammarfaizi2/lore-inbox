Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUIDQF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUIDQF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 12:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUIDQF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 12:05:27 -0400
Received: from k203.denver.dsl.forethought.net ([216.241.42.203]:46293 "EHLO
	sanctuary.aproximation.org") by vger.kernel.org with ESMTP
	id S263818AbUIDQFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 12:05:15 -0400
Date: Sat, 4 Sep 2004 10:05:14 -0600
Message-Id: <200409041605.i84G5E2G008413@sanctuary.aproximation.org>
To: "linux_help" <linux-kernel@vger.kernel.org>
Subject: Problem: Compiling kernel: -lqt not found: qt not equal qt-mt?
From: "thewade" <pdman@aproximation.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract:
   I cannot compile kernel linux-2.6.8-1.521 (fc2) on AMD 64 laptop
   because compiler cannot find -lqt.
   
Description:
   Ihave a AMD64 laptop and Im trying to rebuild the FC2 2.6.8 kernel but
   build cant find -lqt.
   Is it because its 64 bit or named qt-mt?
   
   I think ld finds -lqt because if I rin ldconfig -p | grep qt I get
   
   libqui.so.1 (libc6,x86-64) => /usr/lib64/qt-3.3/lib/libqui.so.1
   libqui.so (libc6,x86-64) => /usr/lib64/qt-3.3/lib/libqui.so
   libqtmcop.so.1 (libc6,x86-64) => /usr/lib64/libqtmcop.so.1
   libqt-mt.so.3 (libc6,x86-64) => /usr/lib64/qt-3.3/lib/libqt-mt.so.3
   libqt-mt.so (libc6,x86-64) => /usr/lib64/qt-3.3/lib/libqt-mt.so
   
   and libqt-mt is the same as libqt, just a newer version?

Support:
   My ld.so.conf looks like this:
   include ld.so.conf.d/*.conf
   /usr/X11R6/lib  
   /usr/X11R6/lib64
   /usr/lib64
   /usr/lib64/qt-3.3/lib
   
   my LD_LIBRARY_PATH is
/usr/lib64/qt-3.3/lib:/usr/local/lib64:/usr/local/lib:/usr/lib64:/usr/lib:$
   
   Ive run ldconfig with this configuration.
   
   scripts/ver_linux:
   Linux localhost.localdomain 2.6.5-1.358 #1 Sat May 8 09:01:26 EDT 2004
   x86_64 x86_64 x86_64 GNU/Linux
   
   Gnu C                  3.3.3
   Gnu make               3.80
   binutils               2.15.90.0.3
   util-linux             2.12  
   mount                  2.12  
   module-init-tools      2.4.26
   e2fsprogs              1.35 
   pcmcia-cs              3.2.7
   quota-tools            3.10.
   PPP                    2.4.2
   nfs-utils              1.0.6
   Linux C Library        2.3.3
   Dynamic linker (ldd)   2.3.3
   Procps                 3.2.0
   Net-tools              1.60
   Kbd                    1.12
   Sh-utils               5.2.1
   Modules Loaded         joydev parport_pc lp parport autofs4 snd_hdsp
   snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd_hwdep
   snd soundcore ds yenta_socket pcmcia_core sunrpc sis900 ipt_REJECT
   ipt_state ip_conntrack iptable_filter ip_tables sg scsi_mod ipv6 dm_mod
   ohci_hcd ehci_hcd button battery asus_acpi ac ext3 jbd
   
Thank you for you help, ive waisted three days with this problem staring
stupidly at the screen and posting to fedoraforum.org
(http://www.fedoraforum.org/forum/showthread.php?p=97891)
(http://www.fedoraforum.org/forum/showthread.php?p=97712)
-thewade

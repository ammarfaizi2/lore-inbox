Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSGEVgK>; Fri, 5 Jul 2002 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSGEVgJ>; Fri, 5 Jul 2002 17:36:09 -0400
Received: from ofree.wp-sa.pl ([212.77.101.203]:28353 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id <S317582AbSGEVgJ>;
	Fri, 5 Jul 2002 17:36:09 -0400
Date: Fri,  5 Jul 2002 23:18:30 +0200
From: "kenorb -" <kenorb@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: make: *** [menuconfig] Error 139
Message-ID: <3d260d2698c0c@wp.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-IP: 62.233.159.2
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
My ncurses is installed correctly.
I haved run: make menuconfig.
I use Putty to connect to remote server, and I haved change 
resolution from 63 rows and 142 columns to 24/80 r/c. Before I 
can press up/down, but if I press Enter, on the screen I see:
<--cut-->
There seems to be a problem with the lxdialog companion utility 
which is
built prior to running Menuconfig.  Usually this is an indicator 
that you
have upgraded/downgraded your ncurses libraries and did not 
remove the
old ncurses header file(s) in /usr/include 
or /usr/include/ncurses.

It is VERY important that you have only one set of ncurses 
header files
and that those files are properly version matched to the ncurses 
libraries
installed on your machine.

You may also need to rebuild lxdialog.  This can be done by 
moving to
the /usr/src/linux/scripts/lxdialog directory and issuing the
"make clean all" command.

If you have verified that your ncurses install is correct, you 
may email
the maintainer <mec@shout.net> or post a message to
<linux-kernel@vger.kernel.org> for additional assistance.

make: *** [menuconfig] Error 139
<--cut-->
so?
Is this bug is fixed? If yes sorry.
Sorry for my bad English.
Bye


-----------------------------------------------------------------------
Chcesz co¶ sprzedaæ ? Chcesz co¶ kupiæ ?
Najlepsze oferty ! Zobacz www.gratka.pl !


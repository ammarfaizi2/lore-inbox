Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSHGXxV>; Wed, 7 Aug 2002 19:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSHGXxV>; Wed, 7 Aug 2002 19:53:21 -0400
Received: from pD9E231F8.dip.t-dialin.net ([217.226.49.248]:11235 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317036AbSHGXxS>; Wed, 7 Aug 2002 19:53:18 -0400
Date: Wed, 7 Aug 2002 17:56:54 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: David Weinehall <tao@acc.umu.se>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.0] My part of the history lesson: Documentation/Changes
Message-ID: <Pine.LNX.4.44.0208071752130.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This updates lots of old and dusty URLs. I'm not yet through with them, 
but I feel like it's time for Ctrl-D, I only have two hours left to 
sleep...

[CC'ing LKML because the history might be interesting sometimes, and 
 because sleepless nights make me unresponsable...]

--- linux-2.0.40/Documentation/Changes	Tue Jan  9 14:29:20 2001
+++ thunder-2.0/Documentation/Changes	Wed Aug  7 17:51:39 2002
@@ -68,6 +68,9 @@
 - Net-tools              1.32-alpha
 - Kbd                    0.91
 
+Note that you won't be able  to compile the 2.0 kernel with gcc-3.1 or
+binutils 2.9.
+
 Upgrade notes
 *************
 
@@ -107,7 +110,7 @@
 use the new features you'll need to upgrade your bootloaders.  Lilo can
 be found at ftp://lrcftp.epfl.ch/pub/linux/local/lilo/lilo.19.tar.gz.
 LOADLIN is at
-ftp://sunsite.unc.edu/pub/Linux/system/Linux-boot/lodlin16.tgz.  If
+ftp://sunsite.unc.edu/pub/linux/system/boot/dualboot/lodlin16.tgz.  If
 you're using more unusual loaders like SysLinux or etherboot, the
 latest versions are 1.3 and 2.0, respectively.
 
@@ -169,7 +172,7 @@
    in linux/fs/locks.c and recompile.  If you're still running a.out,
 there's an unofficial libc-4.7.6 release out to which you can upgrade
 to fix this problem.  Libc is available from
-ftp://sunsite.unc.edu/pub/Linux/GCC/.
+ftp://ftp.win.tue.nl/pub/linux-local/libc.archive/libc/.
 
 GCC Signal 11 error
 ===================
@@ -198,7 +201,7 @@
 upgrade procps to the latest release, currently 1.01.  Otherwise,
 you'll get floating point errors with some ps commands or other similar
 surprises.  Grab
-ftp://sunsite.unc.edu/pub/Linux/system/Status/ps/procps-1.01.tgz.
+ftp://sunsite.unc.edu/pub/historic-linux/ftp-archives/sunsite.unc.edu/Sep-29-1996/system/Status/ps/procps-1.01.tar.gz.
 
 Kernel Modules
 ==============
@@ -206,8 +209,9 @@
    Almost all drivers in 2.0.x can be modules, and kerneld is now
 incorporated into the kernel.  To take advantage of this, you'll need
 the latest version of the module support apps. These are available at
-http://www.pi.se/blox/modules/modules-2.0.0.tar.gz.  Note: If you try to
-load a module and get a message like
+ftp://sunsite.unc.edu/pub/linux/kernel.org/pub/linux/kernel/v2.0/modules-2.0.0.tar.gz.
+
+Note: If you try to load a module and get a message like
 
    `gcc2_compiled, undefined Failed to load module!  The symbols from
 kernel 1.3.foo don't match 1.3.foo'
@@ -241,7 +245,7 @@
 
    You need to be running a pppd from ppp-2.2.0.tar.gz or greater.  The
 latest stable release is 2.2.0f and is available at
-ftp://sunsite.unc.edu/pub/Linux/system/Network/serial/ppp/ppp-2.2.0f.tar.gz.
+ftp://sunsite.unc.edu/pub/historic-linux/distributions/slackware/3.1/source/n/ppp/ppp-2.2.0f.tar.gz.
 
 Named pipes (SysVinit)
 ======================
@@ -253,7 +257,7 @@
 your computer shuts down fine but "INIT: error reading initrequest" or
 words to that effect scroll across your screen hundreds of times.  To
 fix, upgrade to
-ftp://sunsite.unc.edu/pub/Linux/system/Daemons/init/sysvinit-2.64.tar.gz.
+ftp://sunsite.unc.edu/pub/historic-linux/ftp-archives/sunsite.unc.edu/Sep-29-1996/system/Daemons/init/sysvinit-2.64.tar.gz.
 
    If you're trying to run NCSA httpd, you might have problems with
 pre-spawning daemons.  Upgrade to the latest release (1.5.2), available
@@ -284,20 +288,20 @@
 details.  Among the programs this has impacted are older sendmails.  If
 you get a message that sendmail cannot lock aliases.dir (or other
 files), you'll need to upgrade to at least 8.7.x. The latest sendmail
-is at ftp://ftp.cs.berkeley.edu/ucb/src/sendmail/sendmail.8.8.7.tar.gz.
+is at ftp://ftp.cs.berkeley.edu/ucb/src/sendmail/.
 
 Uugetty
 =======
 
    Older uugettys will not allow use of a bidirectional serial line.  To
 fix this problem, upgrade to
-ftp://sunsite.unc.edu/pub/Linux/system/Serial/getty_ps-2.0.7i.tar.gz.
+ftp://tucows.belgium.eu.net/pub/linux/slackware/slackware-3.3/source/a/getty/getty_ps-2.0.7i.tar.gz.
 
 Kbd
 ===
 
    For those of you needing non-ASCII character/font support, you should
-upgrade to ftp.funet.fi:/pub/OS/Linux/PEOPLE/Linus/kbd-0.91.tar.gz.
+upgrade to ftp.funet.fi:/pub/OS/Linux/PEOPLE/Linus/old-kbd/kbd-0.91.tar.gz.
 
 Mount
 =====
@@ -306,7 +310,7 @@
 currently at release 2.5.  Some may find, especially when using the
 loop or xiafs file system, NFS, or automounting, that they need to
 upgrade to the latest release of mount, available from
-ftp://ftp.win.tue.nl/pub/linux/util/mount-2.5p.tar.gz.
+ftp://ftp.win.tue.nl/pub/linux/utils/attic/mount/mount-2.5p.tar.gz.
 
 Console
 =======
@@ -321,14 +325,15 @@
    ln -s /usr/lib/terminfo/l/linux /usr/lib/terminfo/c/console
 
    Better yet, just get the latest official Linux termcap from
-ftp://sunsite.unc.edu/pub/Linux/GCC/termcap-2.0.8.tar.gz.  If you
-upgrade to this release read the `README' file contained into the
-package to get some important information about the `tgetent' function
-changes!  Note that there is now a fixed version at
-ftp://sunsite.unc.edu/pub/Linux/GCC/termcap-2.0.8.fix.  If some of your
-apps complain that termcap entries are too long and you don't need some
-of the more esoteric terms in the standard 2.0.8 termcap, just download
-termcap-2.0.8.fix and move it to /etc/termcap.
+ftp://sunsite.unc.edu/pub/historic-linux/distributions/slackware/3.1/source/d/libc/termcap-2.0.8.tar.gz.
+If you upgrade  to this release read the  `README' file contained into
+the  package to  get some  important information  about  the `tgetent'
+function changes!
+Note that there is now a fixed version at
+ftp://sunsite.unc.edu/pub/historic-linux/ftp-archives/sunsite.unc.edu/Sep-19-1996/GCC/termcap-2.0.8.fix.
+If some  of your apps complain  that termcap entries are  too long and
+you don't need  some of the more esoteric terms  in the standard 2.0.8
+termcap, just download termcap-2.0.8.fix and move it to /etc/termcap.
 
    Also, the console driver is now responsible for keeping track of
 correspondence between character codes and glyph bitmaps.  If you
@@ -340,7 +345,7 @@
 
    Hdparm has been upgraded to take advantage of the latest features of
 the kernel drivers.  The latest non-beta version can be found at
-ftp://sunsite.unc.edu/pub/Linux/kernel/patches/diskdrives/hdparm-3.1.tar.gz.
+ftp://sunsite.unc.edu/pub/linux-historic/ftp-archives/sunsite.unc.edu/Sep-19-1996/kernel/patches/diskdrives/hdparm-3.1.tar.gz.
 
 IP Accounting
 =============
@@ -354,7 +359,8 @@
    There also exists a possibility to match on device names and/or
 device addresses, so that only packets coming in/going out via that
 device (network interface) match with a rule.  You'll need to get
-ipfwadm from ftp://ftp.xos.nl/pub/linux/ipfwadm/ipfwadm-2.3.0.tar.gz to
+ipfwadm from
+ftp://ftp.sunsite.auc.dk/disk2/slackware/slackware-8.0/pasture/pasture-sources/ipfwadm-2.3.0/ipfwadm-2.3.0.tar.gz to
 use this.
 
 IP Firewalls
@@ -367,7 +373,8 @@
 so that only packets coming in/going out via that device (network
 interface) match with a rule.  This is especially useful to prevent
 spoofing.  You'll need to get
-ftp://ftp.xos.nl/pub/linux/ipfwadm/ipfwadm-2.3.0.tar.gz to use this.
+ftp://ftp.sunsite.auc.dk/disk2/slackware/slackware-8.0/pasture/pasture-sources/ipfwadm-2.3.0/ipfwadm-2.3.0.tar.gz to
+to use this.
 
 IP Masquerading
 ===============
@@ -376,7 +383,8 @@
 always need to load separate modules (ip_masq_ftp.o and/or
 ip_masq_irc.o) if you are going to use FTP or IRC in combination with
 masquerading.  You'll need to get
-ftp://ftp.xos.nl/pub/linux/ipfwadm/ipfwadm-2.3.0.tar.gz to use this.
+ftp://ftp.sunsite.auc.dk/disk2/slackware/slackware-8.0/pasture/pasture-sources/ipfwadm-2.3.0/ipfwadm-2.3.0.tar.gz to
+to use this.
 
    To enable IP forwarding, you may need to
 
@@ -388,28 +396,28 @@
 ============
 
    The new kernels support ISDN.  You'll need ISDN utils available from
-ftp://ftp.franken.de/pub/isdn4linux/v2.0/isdn4k-utils-2.0.tar.gz to try
-this.
+ftp://ftp.uni-jena.de/pub/fsu/rz/software/linux/internetworking/isdn/isdn4k-utils-2.0.tar.gz
+to try this.
 
 Frame Relay
 ===========
 
-   Frame relay support for Linux is now available as well.  Currently,
+   Frame relay support for Linux is now available as well. Currently,
 only Sangoma cards are supported, but the interface is such that others
-will be as drivers become available.  To use this, grab
-ftp://linux.invlogic.com/pub/fr/frad-0.15.tgz (soon to be
-frad-0.20.tgz).  Another package of interest is
-ftp://linux.invlogic.com/pub/routing/routing.tgz (which allows Linux to
-make routing decisions based on packet source).
+will be as drivers become available. To use this, grab
+ftp://ftp.task.gda.pl/mirror/ftp.invlogic.com/pub/fr/frad-0.15.tgz
+(soon to be frad-0.20.tgz). Another package of interest is
+ftp://ftp.task.gda.pl/mirror/ftp.invlogic.com/pub/routing/routing-2.0.33.tgz
+(which allows Linux to make routing decisions based on packet source).
 
 Networking
 ==========
 
    Some of the /proc/net entries have changed.  You'll need to upgrade
 to the latest net-tools in
-ftp://ftp.inka.de/pub/comp/Linux/networking/NetTools/, where the latest
-is currently net-tools-1.32-alpha.tar.gz.  See
-http://www.inka.de/sites/lina/linux/NetTools/index_en.html for more
+ftp://ftp.task.gda.pl/mirror/ftp.invlogic.com/pub/linux/routing/,
+where the latest is currently net-tools-1.33.tar.gz.
+See http://www.inka.de/sites/lina/linux/NetTools/index_en.html for more
 information.  Note that there is currently no ipfw (which is part of
 net-tools) which works with 2.0.x kernels.  If you need its functions,
 learn how to use ipfwadm or patch ipfw to get it to work (ipfw's current
@@ -426,10 +434,11 @@
 ============
 
    The sound driver was upgraded in the 2.0.x kernels, breaking vplay.
-To fix this problem, get a new version of the sndkit from
-ftp://ftp.best.com/pub/front/tasd/snd-util-3.5.tar.gz.  Some users
-report that various other sound utils (cdd2wav-sbpcd, for example) need
-to be recompiled before they will work with the new kernels.
+To  fix  this   problem,  get  a  new  version   of  the  sndkit  from
+ftp://sunsite.unc.edu/pub/historic-linux/distributions/slackware/3.1/source/extra-stuff/sound-utilities/snd-util-3.5.tar.gz.
+Some users  report that various other sound  utils (cdd2wav-sbpcd, for
+example)  need to be  recompiled before  they will  work with  the new
+kernels.
 
 Tcsh
 ====
@@ -459,8 +468,8 @@
 file as a file system, which can allow for all sorts of cool things
 like encrypted file systems and such.  To use it, you'll need a
 modified version of mount from
-ftp://ftp.win.tue.nl/pub/linux/util/mount-2.5k.tar.gz; preliminary work
-on encrypted file system support can be found in
+ftp://ftp.win.tue.nl/pub/linux-local/utils/attic/mount/mount-2.5k.tar.gz;
+preliminary work on encrypted file system support can be found in
 ftp.funet.fi:/pub/Linux/BETA/loop/des.1.tar.gz.
 
 Multiple device

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-


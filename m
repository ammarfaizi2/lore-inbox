Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUF0QX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUF0QX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUF0QX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:23:29 -0400
Received: from mail.nvc.net ([66.35.110.252]:62223 "EHLO mail.nvc.net")
	by vger.kernel.org with ESMTP id S263806AbUF0QXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:23:24 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm1,2,3 issues with sata and usb
Date: Sun, 27 Jun 2004 11:22:41 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406271122.41089.kashouty@dakotainet.net>
From: Merwan Kashouty <kashouty@dakotainet.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am not having any luck from any of the mm releases above 2.6.7-rc3-mm2... 
all kernels result in a kernel panic unable to open the root filesystem on 
the via sata controller. i have successfully booted 2.6.7-bk1,2,3,4,5,6,7 ... 
starting at 6 the drive changes from being seen as hdg to sdb as it should be 
seen (i am using a asus-sk8v mainboard) since the sata driver is taking 
controll of the device rather then the via-ide driver. 2.6.7-bk8 kernel 
panics again unable to find the filesystem... bk9 and bk10 again work.
i am not sure the source for the mm3 patch but it would appear to be bk8...lol

here is my system info:

rommel@JaiBaba rommel $ emerge info
Portage 2.0.50-r8 (gcc34-amd64-2004.1, gcc-3.4.0, glibc-2.3.4.20040605-r0, 
2.6.7-bk10)
=================================================================
System uname: 2.6.7-bk10 x86_64 5
Gentoo Base System version 1.4.16
Autoconf: sys-devel/autoconf-2.59-r4
Automake: sys-devel/automake-1.8.5-r1
ACCEPT_KEYWORDS="amd64 ~amd64"
AUTOCLEAN="yes"
CFLAGS="-O2 -march=k8 -pipe -ftracers -fweb"
CHOST="x86_64-pc-linux-gnu"
COMPILER="gcc3"
CONFIG_PROTECT="/etc /usr/X11R6/lib/X11/xkb /usr/kde/2/share/config /usr/kde/3.2/share/config /usr/kde/3/share/config /usr/share/config /var/qmail/control"
CONFIG_PROTECT_MASK="/etc/gconf /etc/terminfo /etc/env.d"
CXXFLAGS="-O2 -march=k8 -pipe -ftracers -fweb"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoaddcvs ccache sandbox"
GENTOO_MIRRORS="http://gentoo.chem.wisc.edu/gentoo/"
MAKEOPTS="-j2"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY=""
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="X alsa amd64 apm arts avi berkdb cdr crypt dvd dvdr encode esd foomaticdb 
gdbm gif gnome gpm gtk gtk2 imlib jpeg kde libg++ libwww mikmod motif mpeg 
ncurses nls ntpl oggvorbis opengl oss pam pdflib perl png python qt quicktime 
readline sdl slang spell ssl tcpd truetype xml2 xmms xv zlib"

both bk8 and mm1,2,3 pause for a terribly long time to determine the status of 
the drives attached to the via-sata controller after which the kernel 
eventually moves on to end in a panic. sometimes i get a usb error line just 
after the panic then the system locks.

CC me if you can and i will be glad to provide anything further that i can or 
test what ever you like to resolve/improve this.

ciao

merwan

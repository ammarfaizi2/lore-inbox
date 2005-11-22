Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVKVDLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKVDLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVKVDLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:11:51 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:36848 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751271AbVKVDLu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:11:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WUTYSil++IDJ0fF9CKrqJdIdnyePu5CFaVndOmHxrnXh6Jwwo2WW5H0PQOt5sn+7CFCTGVhVYZwSG1dE+d4d5Hs1z4l3RQrHksiVsSU8csFFl7SjaGOsXZeyhG21DxsqjXw4ATU+gWppeVrkwdgAVWYi87IFDe9MqvLelDZzZy8=
Message-ID: <625fc13d0511211911j10f8e87dha9be0b71a298c60d@mail.gmail.com>
Date: Mon, 21 Nov 2005 21:11:49 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: scjody@steamballoon.com, gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] Add more SCM trees to MAINTAINERS
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg requested a patch to update MAINTAINERS with more SCM entries. 
The patch below is what I've found so far.

Also, you should be able to pull from:

http://jdub.homelinux.org/pub/jwb-2.6.git

unless I've totally screwed something up.  Which is entirely possible,
since I'm pretty new to git itself.  I did test it locally though.

josh
---

Signed-off-by: Josh Boyer <jwboyer@gmail.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e84be3..92cf36c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -227,6 +227,7 @@ AGPGART DRIVER
 P:	Dave Jones
 M:	davej@codemonkey.org.uk
 W:	http://www.codemonkey.org.uk/projects/agp/
+T:	git kernel.org:/pub/scm/linux/kernel/git/davej/agpgart.git
 S:	Maintained

 AHA152X SCSI DRIVER
@@ -384,6 +385,7 @@ P:	David Woodhouse
 M:	dwmw2@infradead.org
 L:	linux-audit@redhat.com
 W:	http://people.redhat.com/sgrubb/audit/
+T:	git kernel.org:/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git
 S:	Maintained

 AX.25 NETWORK LAYER
@@ -432,6 +434,7 @@ L:	bluez-devel@lists.sf.net
 W:	http://bluez.sf.net
 W:	http://www.bluez.org
 W:	http://www.holtmann.org/linux/bluetooth/
+T:	git kernel.org:/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
 S:	Maintained

 BLUETOOTH RFCOMM LAYER
@@ -547,6 +550,7 @@ P:	Steve French
 M:	sfrench@samba.org
 L:	samba-technical@lists.samba.org
 W:	http://us1.samba.org/samba/Linux_CIFS_client.html
+T:	git kernel.org:/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
 S:	Supported	

 CIRRUS LOGIC GENERIC FBDEV DRIVER
@@ -608,6 +612,7 @@ P:	Dave Jones
 M:	davej@codemonkey.org.uk
 L:	cpufreq@lists.linux.org.uk
 W:	http://www.codemonkey.org.uk/projects/cpufreq/
+T:	git kernel.org/pub/scm/linux/kernel/davej/cpufreq.git
 S:	Maintained

 CPUID/MSR DRIVER
@@ -641,6 +646,7 @@ M:	herbert@gondor.apana.org.au
 P:	David S. Miller
 M:	davem@davemloft.net
 L:	linux-crypto@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
 S:	Maintained

 CYBERPRO FB DRIVER
@@ -1185,6 +1191,7 @@ P:	Bartlomiej Zolnierkiewicz
 M:	B.Zolnierkiewicz@elka.pw.edu.pl
 L:	linux-kernel@vger.kernel.org
 L:	linux-ide@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
 S:	Maintained

 IDE/ATAPI CDROM DRIVER
@@ -1279,6 +1286,7 @@ P:	Vojtech Pavlik
 M:	vojtech@suse.cz
 L:	linux-input@atrey.karlin.mff.cuni.cz
 L:	linux-joystick@atrey.karlin.mff.cuni.cz
+T:	git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained

 INOTIFY
@@ -1392,6 +1400,7 @@ P:	Kai Germaschewski
 M:	kai.germaschewski@gmx.de
 L:	isdn4linux@listserv.isdn4linux.de
 W:	http://www.isdn4linux.de
+T:	git kernel.org:/pub/scm/linux/kernel/kkeil/isdn-2.6.git
 S:	Maintained

 ISDN SUBSYSTEM (Eicon active card driver)
@@ -1420,6 +1429,7 @@ P:	Dave Kleikamp
 M:	shaggy@austin.ibm.com
 L:	jfs-discussion@lists.sourceforge.net
 W:	http://jfs.sourceforge.net/
+T:	git kernel.org:/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git
 S:	Supported

 KCONFIG
@@ -1534,6 +1544,7 @@ P:	Paul Mackerras
 M:	paulus@samba.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
 S:	Supported

 LINUX FOR POWER MACINTOSH
@@ -1601,6 +1612,7 @@ P:	Chris Wright
 M:	chrisw@osdl.org
 L:	linux-security-module@wirex.com
 W:	http://lsm.immunix.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git
 S:	Supported

 LM83 HARDWARE MONITOR DRIVER
@@ -1816,6 +1828,7 @@ M:	yoshfuji@linux-ipv6.org
 P:	Patrick McHardy
 M:	kaber@coreworks.de
 L:	netdev@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/davem/net-2.6.git
 S:	Maintained

 IPVS
@@ -1867,6 +1880,7 @@ M:	aia21@cantab.net
 L:	linux-ntfs-dev@lists.sourceforge.net
 L:	linux-kernel@vger.kernel.org
 W:	http://linux-ntfs.sf.net/
+T:	git kernel.org:/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git
 S:	Maintained

 NVIDIA (RIVA) FRAMEBUFFER DRIVER
@@ -2390,6 +2404,7 @@ P:	Anton Blanchard
 M:	anton@samba.org
 L:	sparclinux@vger.kernel.org
 L:	ultralinux@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git
 S:	Maintained

 SHARP LH SUPPORT (LH7952X & LH7A40X)
@@ -2528,6 +2543,7 @@ P:      Adrian Bunk
 M:      trivial@kernel.org
 L:      linux-kernel@vger.kernel.org
 W:      http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/
+T:      git kernel.org:/pub/scm/linux/kernel/git/bunk/trivial.git
 S:      Maintained

 TMS380 TOKEN-RING NETWORK DRIVER
@@ -2861,6 +2877,7 @@ P:      Latchesar Ionkov
 M:      lucho@ionkov.net
 L:      v9fs-developer@lists.sourceforge.net
 W:      http://v9fs.sf.net
+T:      git kernel.org:/pub/scm/linux/kernel/ericvh/v9fs-devel.git
 S:      Maintained

 VIDEO FOR LINUX

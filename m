Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424501AbWKKKOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424501AbWKKKOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424508AbWKKKOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 05:14:08 -0500
Received: from web26909.mail.ukl.yahoo.com ([217.146.176.98]:60319 "HELO
	web26909.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1424501AbWKKKOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 05:14:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IWMB1erTKV2JSeanYYdBhya3ngW8CuChGBMnoxlZLJgBDR9XEuWgqkRbnwIGsjp8MohMMBeK/ntZTE2Jptc/277c53DvHkdJ05ifLmK6J79IkJN0MQKVgTnz+nv8Fwb0+MFckx49DbSUwYdcoNKvuVuqeT7P6XkRADsoFO1P5Hc=  ;
Message-ID: <20061111101404.35322.qmail@web26909.mail.ukl.yahoo.com>
Date: Sat, 11 Nov 2006 11:14:04 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: [ANNOUNCE] Gujin PC graphic bootloader version 1.6
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

 A new version of the Gujin bootloader is out, still using the 32 bits entry
point of the kernel. It has improved quite a bit, but not all improvement are
related to booting Linux (improvements in booting CD/DVDroms, floppy or full
disk images on HD/CDROM, mixed USB-FDD/USB-HDD boot mode, execution of
standalone *.kgz...).
 Still, you can now use Gujin to boot a kernel and an initramfs, that is an
initrd that shall not be uncompressed (and so no validity check can be
done) because this file is (may be) a collection of GZIP files. This kind of
file shall have a name beginning with "initra", maybe followed by "mfs" and
maybe followed by ".img" like "initrd" - It is treated the same way as initrd,
associated to kernels depending of their position on the disk (same disk,
partition, and directory as the considered kernel) and depending of the end
of the filename (usually the version part).
 Also, the Linux parameter line can be now easily edited with arrow keys, in
the setup screen of Gujin, at boot time. This command line is saved in between
reboots only if Gujin is allowed to write to disks (another checkbox).

 To install, you should read at least the top of install.txt, mostly if
you have SATA drives (you may have to force EBIOS mode because your chipset
may not be ATA compatible - unlike what the SATA specification says).
 To upgrade, cold boot the PC into Gujin, uninstall with the setup menu,
boot your Linux distribution and re-install Gujin.

 Home page and screenshoots of Gujin at:
http://gujin.org

 More information for Gujin on Wikipedia:
http://en.wikipedia.org/wiki/Gujin

 Downloads at Sourceforge:
http://sourceforge.net/projects/gujin

 FAQ/HOWTO at sourceforge:
http://sourceforge.net/docman/display_doc.php?docid=1989&group_id=15465

  Have fun,
  Etienne.


	

	
		
___________________________________________________________________________ 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses 
http://fr.answers.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTFIVes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTFIVer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:34:47 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:51978 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262165AbTFIVe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:34:26 -0400
Subject: [PATCHSET] 2.4.21-rc6-dis3 released
From: Disconnect <kernel@gotontheinter.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055195284.19815.55.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jun 2003 17:48:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am happy to announce the 3rd release of my laptop-oriented patchset. 
Some patches that I liked in -dis1 and -dis2 are missing, notably
packet-mode cdrw/dvd writing, because they proved unstable.  (A couple
of others are missing because they proved unmergable; they might come
back if anyone wanted them.  If your favorite patch went away, mail me
and let me know..)

Its been very stable for me for about 3 days, including swsusp, boot
winxp, read-only-mount the ext3 fs as ext2, copy stuff off, etc, then
resume linux.

Bug reports welcome, and nvidia users, I'm still looking to hear from
more of you.  (Those of you who have responded already should have
replies by now; if not, let me know..)

The patch is against 2.4.21-rc6 and is available at
http://www.gotontheinter.net/kernel/ (including an untested update to
rc7)

Included:
 - ACPI 20030523-2.4.21-rc3.diff
 - journal-deadlock-on-mount
(http://marc.theaimsgroup.com/?l=linux-kernel&m=105433050315208&w=2)
 - BCM4400 driver integrated (this may be bad:
http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week04/0165.html ..)
 - patch-acpi-acpi20021212-swsusp19.gz
 - add CONFIG_ACPI_I8500 for custom DSDT - no more patching needed for
non-I8500 users!
 - 1080_NF2_0305311048_2.4.21-ck1.patch - Nvidia Nforce2 update. Lemme
know if this helps. (Yep, as with several of these its stolen from -CK..
yay for Con!)
 - 1100_CFS_0305311539_2.4.21-ck1.patch - CPUfreq (no modifications this
time)
 - orinoco-0.11b-patch for monitor-mode
 - linux-2.4.13-vfat-symlink-0.90
 - trackpad-2.4.20, latest version (Tue, 27 May 2003 22:47:06 +0200)
 - patch-agp for swsusp on i810 motherboards
 - 1020_RL2_0305310042_2.4.21-ck1.patch.bz2 Read Latency2
 - 025_ide-cd-dma-4 (from -jp) -- use dma to read audio cds
 - 065_cdfs-0.5b 0.5c (also from -jp)
 - 068_ntfs-22a (jp again, yay) - new NTFS
 - Removed OSS, patched in alsa (from -jp)



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTFRLG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTFRLG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:06:56 -0400
Received: from falcon.ericsson.se ([193.180.251.52]:18835 "EHLO
	falcon.al.sw.ericsson.se") by vger.kernel.org with ESMTP
	id S265145AbTFRLGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:06:55 -0400
Message-ID: <5E5172B4DE05D311B3AB0008C75DA941123CEF53@edeacnt100.eed.ericsson.se>
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Sourabh Ladha (EED)" <Sourabh.Ladha@eed.ericsson.se>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic while upgrading from 2.4.20 to 2.5.70
Date: Wed, 18 Jun 2003 13:19:30 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[I know this has been discussed before but I tried the previous fixes proposed without luck..so]

I was trying to upgrade my kernel from 2.4.20 to 2.5.70. (I am running RedHat 9). After getting the sources I did:

make clean; make mrproper; make distclean; make menuconfig; make bzImage; make modules; make modules_install; make install   (got past all of these)

The make install updated my grub.conf as well. When I reboot the system tries to boot up but I get a kernel panic with the error:

mount: error 19 mounting ext3
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
umount /initrd/proc failed: 2
Freeing unused kernel memory: 224k freed
Kernel panic: No init found. Try passing init= option to kernel

Some random, no-clue attempts of fixing included: removing the ext3 support and then rebuilding the kernel, making my old config file's (2.4.20) filesystem options same as the new one and then rebuilding..but no luck.

Could anyone please let me know what can I do to get 2.5.70 working ?


Thanks,
Sourabh

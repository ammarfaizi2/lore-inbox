Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbULFS3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbULFS3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbULFS3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:29:49 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:27828 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261602AbULFS3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:29:48 -0500
From: "Niel Lambrechts" <antispam@telkomsa.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel panic after changing processor arch
Date: Mon, 6 Dec 2004 20:29:44 +0200
Message-ID: <000001c4dbc1$8fdc0a30$0a00000a@MERCKX>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hoping someone can help:

I am trying to recompile using processor architecture PENTIUMM instead
of i586/i686.

Mkinitrd is used to create an initial ramdisk, but upon reboot I get:

reiserfs: version magic '2.6.8-24.5-default PENTIUMM REGPARM gcc-3.3'
should be '2.6.8-24.5-default 586 REGPARM gcc-3.3'
insmod: error inserting
'/lib/modules/2.6.8-24.5-default/kernel/fs/reiserfs/reiserfs.ko': -1
invalid module format
Waiting for device /dev/hda3 to appear: ok
rootfs: major=3 minor=3 devn=771
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(3,3)

I have tried other mailing-lists to no avail. Any ideas?

-Niel


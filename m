Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130719AbRCEWKr>; Mon, 5 Mar 2001 17:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130718AbRCEWKl>; Mon, 5 Mar 2001 17:10:41 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:57576 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S130706AbRCEWJ4>;
	Mon, 5 Mar 2001 17:09:56 -0500
Message-ID: <FFD40DB4943CD411876500508BAD027901DE2C12@sj5-ex2.brocade.com>
From: Amit Chaudhary <amitc@brocade.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: continous hard disk trashing and error messages - 2.4.2-ac5
Date: Mon, 5 Mar 2001 14:09:48 -0800 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For the kernel 2.4.2 with the patch 2.4.2-ac5 patch, I have been getting continous hard disk trashing and the following errors in the /var/log/messages. I increased the console log level to avoid the messages. Please see below a sample set
Mar  5 12:15:59 amitc-linux mount: mount: can't open /etc/mtab for writing: Input/output error
Mar  5 12:16:04 amitc-linux kernel: hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Mar  5 12:16:04 amitc-linux kernel: hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=25133118, sector=3670215
Mar  5 12:16:04 amitc-linux kernel: end_request: I/O error, dev 03:06 (hda), sector 3670215
Mar  5 12:16:04 amitc-linux kernel: EXT2-fs error (device ide0(3,6)): ext2_write_inode: unable to read inode block - inode=230017, block=458776


On a restart I have to do a manual fsck, that was some pretty drastic results incl. removing directories from /var, removing /tmp, etc.

I went through the archives and tried smartctl. That has not given any problems yet. e2fsprogs is 1.19

The systems is basically unusable right now. Please email me if anyone knows where the problem might be?

Thanks and Regards
Amit


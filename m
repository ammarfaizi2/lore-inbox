Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129605AbQKBVzb>; Thu, 2 Nov 2000 16:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbQKBVzW>; Thu, 2 Nov 2000 16:55:22 -0500
Received: from mercury.eng.emc.com ([168.159.40.77]:3588 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S129605AbQKBVzK>; Thu, 2 Nov 2000 16:55:10 -0500
Message-ID: <276737EB1EC5D311AB950090273BEFDD979DF6@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: scsi init problem in 2.4.0-test10?
Date: Thu, 2 Nov 2000 16:49:11 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I met a problem when trying to upgrade my Linux kernel to 2.4.0-test10.
The machine is Compay AP550, dual processor, mem 512 MB, and 863 MHZ freq.
It has two scsi host adaptors. one is AIC-7892 ultra 160/m connected to 
internal hard disk, and the other is AHA-3944 ultra scsi connected to 
an attached disk. The boot process stops after detection of the first
scsi host, error info is:
	scsi: aborting command due to time out: pid0, scsci1, channel 0, 
	id 0, lun 0, Inquiry 00 00 00 ff 00

Previous OS on this machine was RedHat 6.2 kernel version 2.2.14

looking forward to your help!

Xiangping
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

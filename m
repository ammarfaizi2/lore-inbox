Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVKHPs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVKHPs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVKHPs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:48:27 -0500
Received: from spirit.analogic.com ([204.178.40.4]:6411 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965028AbVKHPs0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:48:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 08 Nov 2005 15:48:25.0650 (UTC) FILETIME=[DB03D920:01C5E47B]
Content-class: urn:content-classes:message
Subject: Compatible fstat()
Date: Tue, 8 Nov 2005 10:48:25 -0500
Message-ID: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compatible fstat()
Thread-Index: AcXke9sezGEJx4k8TmO4+SlacLQntQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

The Linux fstat() doesn't return any information number of blocks,
or the byte-length of a physical hard disk.

       Device name : /dev/hda
     Device st_dev : 00000301
    Device st_rdev : 00000300
    Device st_size : 0
  Device st_blocks : 0
Device st_blksize : 4096
       Device name : /dev/sda
     Device st_dev : 00000301
    Device st_rdev : 00000800
    Device st_size : 0
  Device st_blocks : 0
Device st_blksize : 4096
       Device name : /dev/sdb
     Device st_dev : 00000301
    Device st_rdev : 00000810
    Device st_size : 0
  Device st_blocks : 0
Device st_blksize : 4096
       Device name : /dev/sdc
     Device st_dev : 00000301
    Device st_rdev : 00000820
    Device st_size : 0
  Device st_blocks : 0
Device st_blksize : 4096

So, in a PORTABLE way, how do I find the block device with a
certain size, perhaps even the largest or smallest? I need to
have a customer plug in an external drive (USB) and be able
to determine if it's big enough for a raw-data write (no
file-system).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

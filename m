Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSLIBdk>; Sun, 8 Dec 2002 20:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSLIBdk>; Sun, 8 Dec 2002 20:33:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56210 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261446AbSLIBdj>; Sun, 8 Dec 2002 20:33:39 -0500
Date: Sun, 08 Dec 2002 17:41:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel@vger.kernel.org
Subject: qlogic isp1020 broken in 2.5.50
Message-ID: <56340000.1039398073@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone working on this, or know how to backout whatever broke it?
Seem to work fine in 47 (unless just the warning is new, and it's
been broken all along).

---------------

qlogicisp : new isp1020 revision ID (5)
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c01a0c4e>] scsi_register+0x7a/0x308
 [<c01a6734>] isp1020_detect+0x64/0x270
 [<c01a0f0b>] scsi_register_host+0x2f/0xc8
 [<c0105098>] init+0x44/0x19c
 [<c0105054>] init+0x0/0x19c
 [<c0106e81>] kernel_thread_helper+0x5/0xc


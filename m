Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbQKNNMO>; Tue, 14 Nov 2000 08:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131052AbQKNNLz>; Tue, 14 Nov 2000 08:11:55 -0500
Received: from ns.tasking.nl ([195.193.207.2]:40970 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S129896AbQKNNLu>;
	Tue, 14 Nov 2000 08:11:50 -0500
Date: Tue, 14 Nov 2000 13:40:50 +0100
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre4: lockup in AHA-2940A initialization
Message-ID: <20001114134049.A2253@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As reported earlier in test10-pre7 a /sbin/reboot hangs the machine
during boot right at the point marked [HANG]. Have to cycle power to
get it right. Attaching a device makes no difference. 2.2.14 was ok.

Oct 31 13:36:22 area51 kernel: (scsi0) <Adaptec AHA-2940A Ultra SCSI host adapter> found at PCI 0/4/0
Oct 31 13:36:22 area51 kernel: (scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
Oct 31 13:36:22 area51 kernel: (scsi0) Cables present (Int-50 NO, Ext-50 NO)
Oct 31 13:36:22 area51 kernel: (scsi0) Downloading sequencer code... 422 instructions downloaded
[HANG]
Oct 31 13:36:22 area51 kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Oct 31 13:36:22 area51 kernel:        <Adaptec AHA-2940A Ultra SCSI host adapter>

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

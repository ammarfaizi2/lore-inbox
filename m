Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314190AbSDQWkC>; Wed, 17 Apr 2002 18:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314192AbSDQWkB>; Wed, 17 Apr 2002 18:40:01 -0400
Received: from f50.pav2.hotmail.com ([64.4.37.50]:17419 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S314190AbSDQWkB>;
	Wed, 17 Apr 2002 18:40:01 -0400
X-Originating-IP: [166.102.199.91]
From: "bob dobalina" <mrdobalina@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 1 Terabyte+ Disk Support?
Date: Wed, 17 Apr 2002 17:39:51 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F50W2lSYgCSrlrCv3wB00016f23@hotmail.com>
X-OriginalArrivalTime: 17 Apr 2002 22:39:52.0027 (UTC) FILETIME=[C9D14AB0:01C1E660]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am looking for someone who has experience using 1TB+ Disks with the Linux 
2.2.14-5 Kernel that comes standard with Redhat Linux 6.2. I am trying to 
determine the best way to patch a pile of Redhat 6.2 (zoot)systems to 
recognize 1Terabyte and larger disks. I am trying to directly attach 
1.5Terabyte (external) RAID arrays to these Redhat 6.2 systems via Ultra160 
SCSI adapters.

The RAID devices are external rackmount enclosures with their own hardware 
IDE->Ultra160 SCSI RAID Controller. They use 160 Gigabyte IDE drives 
internally in a RAID5 configuration w/ no hot spare. The units striped in 
this configuration present the host they are directly attached to with about 
1.5 Terabytes of storage as (1) Logical
disk. Neither Redhat 6.2 or 7.2 will see properly recognize this large of a 
disk. The dmesg see's the RAID on the SCSI chain, assigns it 'sdb' but 
claims it has a negative number of sectors, and im unable to fdisk the 
device.

The cut-off point for large disks in Redhat 6.2 and 7.2 appears to be around 
900 Gigabytes, I can get both Redhat 6.2 and 7.2 to see up to around 900 
gigs as 1 disk. I've heard about a 64-bit IO patch for an older 2.x.x 'pre8' 
release kernel but would like to know if theres a way to get this 
accomplished with Redhat 6.2/Kernel 2.2.14-5. Any insight into this problem 
would be greatly appreciated!

Thanks!

-Bobd


_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com


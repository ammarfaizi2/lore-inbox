Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267591AbRGZIR4>; Thu, 26 Jul 2001 04:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbRGZIRp>; Thu, 26 Jul 2001 04:17:45 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:47624 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S267591AbRGZIR2>;
	Thu, 26 Jul 2001 04:17:28 -0400
Date: Thu, 26 Jul 2001 10:17:20 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: CDROM access failure
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B5FD210.A98461B5@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


kernel 2.4.3-12.i686 from redhat ( similar behavior on 2.4.6-ac5 too )

/dev/cdrom1 is hdd

[root@localhost /root]# cp /dev/cdrom1 cd.iso & sleep 10
[root@localhost /root]# mount /dev/cdrom1 /mnt/cdrom1
mount: block device /dev/cdrom1 is write-protected, mounting read-only
set_blocksize: b_count 2, dev ide1(22,64), block 16742, from c0159f1a
set_blocksize: b_count 1, dev ide1(22,64), block 16743, from c0159f1a
cp: reading `/dev/cdrom1': Input/output error
[1]+  Exit 1                  cp -i /dev/cdrom1 cd.iso

Is this normal ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -

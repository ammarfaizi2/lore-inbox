Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSLJPPs>; Tue, 10 Dec 2002 10:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSLJPPs>; Tue, 10 Dec 2002 10:15:48 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:37342 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S262038AbSLJPPr>;
	Tue, 10 Dec 2002 10:15:47 -0500
Date: Tue, 10 Dec 2002 10:23:30 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: RAID5 chunksize?
Message-ID: <20021210152330.GP32203@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, say I'm building a 4 disk raid5 array.  Performance is going to be
critical as this system is going to be very IO intensive.  We had to go
RAID5 though due to filesystem requirements.

According to the manufacturer the disks have:

  8Meg DataBuffer
  10K RPM Rotational speed
  SCSI Ultra 160

(Drive is:
http://www.fel.fujitsu.com/home/product.asp?L=en&PID=248&INFO=fsp)

What is the ideal Chunksize?  

Also it's going to have a lot of pretty decent sized files (100Meg or 
so average) so I was going to make it an ext3 with -T largefile and -M 1.

Any other thoughts on how to lay down the disks/filesystem on this
bugger?

Robert





:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130015AbRBGUge>; Wed, 7 Feb 2001 15:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRBGUgO>; Wed, 7 Feb 2001 15:36:14 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:53277 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130015AbRBGUgH>;
	Wed, 7 Feb 2001 15:36:07 -0500
Message-ID: <20010207213604.A21989@win.tue.nl>
Date: Wed, 7 Feb 2001 21:36:04 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Lourenco <andyrock50@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE PROBLEM 2.4.0 and 2.4.1 ...
In-Reply-To: <20010207191207.50272.qmail@web12008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010207191207.50272.qmail@web12008.mail.yahoo.com>; from Lourenco on Wed, Feb 07, 2001 at 11:12:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 11:12:07AM -0800, Lourenco wrote:

> i am getting an error every time i try to copy a big
> file from my cdrom to one of my harddrives...
> 
> PS : It works FINE with 2.2.* and other OS's...
> 
> ...
> VFS: Disk change detected on device ide1(22,0)
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISOFS: changing to secondary root
> isofs_read_level3_size: More than 100 file sections
> ?!?, aborting...
> isofs_read_level3_size: inode=45152 ino=53408
> isofs_read_level3_size: More than 100 file sections
> ?!?, aborting...
> isofs_read_level3_size: inode=45232 ino=53488
> hdc: command error: status=0x51 { DriveReady
> SeekComplete Error }
> hdc: command error: error=0x51
> end_request: I/O error, dev 16:00 (hdc), sector 18356
> hdc: command error: status=0x51 { DriveReady
> SeekComplete Error }

You describe two entirely different things:
(i) the kernel complains that the data on the CD is bad
(ii) the kernel complains that it has problems reading the CD.

The code that generates the message "More than 100 ..."
is almost identical in 2.2 and 2.4 - if you didnt get that
message in 2.2 then perhaps (i) was caused by (ii): there
are problems reading the thing.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

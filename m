Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbREZX01>; Sat, 26 May 2001 19:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbREZXYU>; Sat, 26 May 2001 19:24:20 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262573AbREZW6x>;
	Sat, 26 May 2001 18:58:53 -0400
Message-ID: <3B0FC6A1.857DBF4@Synopsys.COM>
Date: Sat, 26 May 2001 17:07:13 +0200
From: Harald Dunkel <harri@Synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: 'mount /cdrom' doesn't work
In-Reply-To: <3B0FBD25.8956C693@Synopsys.COM> <20010526163232.A553@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sat, May 26 2001, Harald Dunkel wrote:
> > Hi folks,
> >
> > With 2.4.5 my CD and DVD drives have become unaccessable.
> >
> > Can you reproduce this problem?
> 
> Any kernel messages? And please show what happens.
> 

Currently I am back to 2.4.4, but AFAIR I got a message 'no medium found' 
or something like that on the command line.

I have found this in kern.log:

May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr2 at scsi2, channel 0, id 0, lun 0
May 26 15:31:17 bilbo kernel: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
May 26 15:31:17 bilbo kernel: Uniform CD-ROM driver Revision: 3.12
May 26 15:31:17 bilbo kernel: sr1: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
May 26 15:31:17 bilbo kernel: sr2: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
May 26 15:31:17 bilbo kernel: VFS: Disk change detected on device sr(11,1)
May 26 15:31:17 bilbo last message repeated 3 times
May 26 15:31:17 bilbo kernel: Device 0b:01 not ready.
May 26 15:31:17 bilbo kernel:  I/O error: dev 0b:01, sector 1024

Using 2.4.4 the same CD works in the same drive. 


Regards

Harri

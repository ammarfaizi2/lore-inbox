Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSH0UqJ>; Tue, 27 Aug 2002 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSH0UqI>; Tue, 27 Aug 2002 16:46:08 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3853 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317312AbSH0Upy>; Tue, 27 Aug 2002 16:45:54 -0400
Date: Tue, 27 Aug 2002 13:47:37 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
In-Reply-To: <20020827224322.24561e60.us15@os.inf.tu-dresden.de>
Message-ID: <Pine.LNX.4.10.10208271346550.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Will fix as soon as I can down load and clear out current business with
Alan Cox for 2.4.

Cheers,

On Tue, 27 Aug 2002, Udo A. Steinberg wrote:

> On Tue, 27 Aug 2002 12:47:16 -0700 (PDT)
> Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> > Linux 2.5.32 ...
> 
> Hello,
> 
> It looks like the kernel is trying to read partition tables on IDE cdrom drives
> in SCSI emulation mode - and failing at doing so.
> 
> Regards,
> -Udo.
> 
> 
> hda: hda1
> hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
> hde:ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/1
> 
> end_request: I/O error, dev 21:00, sector 0
> Buffer I/O error on device ide2(33,0), logical block 0
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 1, nr/cnr 7/1
> 
> end_request: I/O error, dev 21:00, sector 1
> Buffer I/O error on device ide2(33,0), logical block 1
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/1
> 
> end_request: I/O error, dev 21:00, sector 2
> Buffer I/O error on device ide2(33,0), logical block 2
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 3, nr/cnr 5/1
> 
> end_request: I/O error, dev 21:00, sector 3
> Buffer I/O error on device ide2(33,0), logical block 3
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 4, nr/cnr 4/1
> 
> end_request: I/O error, dev 21:00, sector 4
> Buffer I/O error on device ide2(33,0), logical block 4
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 5, nr/cnr 3/1
> 
> end_request: I/O error, dev 21:00, sector 5
> Buffer I/O error on device ide2(33,0), logical block 5
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 6, nr/cnr 2/1
> 
> end_request: I/O error, dev 21:00, sector 6
> Buffer I/O error on device ide2(33,0), logical block 6
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 7, nr/cnr 1/1
> 
> end_request: I/O error, dev 21:00, sector 7
> Buffer I/O error on device ide2(33,0), logical block 7
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/1
> 
> end_request: I/O error, dev 21:00, sector 0
> Buffer I/O error on device ide2(33,0), logical block 0
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 1, nr/cnr 7/1
> 
> end_request: I/O error, dev 21:00, sector 1
> Buffer I/O error on device ide2(33,0), logical block 1
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/1
> 
> end_request: I/O error, dev 21:00, sector 2
> Buffer I/O error on device ide2(33,0), logical block 2
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 3, nr/cnr 5/1
> 
> end_request: I/O error, dev 21:00, sector 3
> Buffer I/O error on device ide2(33,0), logical block 3
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 4, nr/cnr 4/1
> 
> end_request: I/O error, dev 21:00, sector 4
> Buffer I/O error on device ide2(33,0), logical block 4
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 5, nr/cnr 3/1
> 
> end_request: I/O error, dev 21:00, sector 5
> Buffer I/O error on device ide2(33,0), logical block 5
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 6, nr/cnr 2/1
> 
> end_request: I/O error, dev 21:00, sector 6
> Buffer I/O error on device ide2(33,0), logical block 6
> ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 7, nr/cnr 1/1
> 
> end_request: I/O error, dev 21:00, sector 7
> Buffer I/O error on device ide2(33,0), logical block 7
>  unable to read partition table
> SCSI subsystem driver Revision: 1.00
> 
> 

Andre Hedrick
LAD Storage Consulting Group


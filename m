Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131019AbQKABVE>; Tue, 31 Oct 2000 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbQKABUy>; Tue, 31 Oct 2000 20:20:54 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:13467 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S129061AbQKABUp>; Tue, 31 Oct 2000 20:20:45 -0500
Date: Wed, 1 Nov 2000 01:25:05 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
In-Reply-To: <20001031153106.A9458@suse.de>
Message-ID: <Pine.LNX.4.21.0011010123220.9072-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Jens Axboe wrote:

> Known problem, blocksizes != 2kb does not currently work
> correctly with SCSI CD-ROM (it's even on Ted's list).
> 

doesn't work is one thing.. but an instant lockup? that's a bit
unfriendly. :)

> Same deal, SCSI CD-ROM driver. As you noted, pure ATAPI drive will
> work just fine.
> 

so once the scsi cdrom is fixed then ide-scsi should work too?

> rmmod ide-scsi ; insmod ide-cd
> mount, etc
> rmmod ide-cd ; insmod ide-scsi
> burn
> 

didn't think this was possible. will try that. thanks.

> 

regards,
-- 
Paul Jakma	paul@clubi.ie
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The gent who wakes up and finds himself a success hasn't been asleep.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

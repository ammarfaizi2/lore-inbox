Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129615AbQKAB2Y>; Tue, 31 Oct 2000 20:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbQKAB2O>; Tue, 31 Oct 2000 20:28:14 -0500
Received: from fw.SuSE.com ([202.58.118.35]:5872 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129615AbQKAB15>;
	Tue, 31 Oct 2000 20:27:57 -0500
Date: Tue, 31 Oct 2000 18:33:57 -0800
From: Jens Axboe <axboe@suse.de>
To: Paul Jakma <paul@clubi.ie>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
Message-ID: <20001031183357.B11727@suse.de>
In-Reply-To: <20001031153106.A9458@suse.de> <Pine.LNX.4.21.0011010123220.9072-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011010123220.9072-100000@fogarty.jakma.org>; from paul@clubi.ie on Wed, Nov 01, 2000 at 01:25:05AM +0000
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01 2000, Paul Jakma wrote:
> > Known problem, blocksizes != 2kb does not currently work
> > correctly with SCSI CD-ROM (it's even on Ted's list).
> > 
> 
> doesn't work is one thing.. but an instant lockup? that's a bit
> unfriendly. :)

It's untested behaviour at this point, all bets are off. It
hasn't oopses here though...

> > Same deal, SCSI CD-ROM driver. As you noted, pure ATAPI drive will
> > work just fine.
> > 
> 
> so once the scsi cdrom is fixed then ide-scsi should work too?

Yup

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

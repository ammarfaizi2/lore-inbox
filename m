Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129437AbQK3LzI>; Thu, 30 Nov 2000 06:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQK3LzA>; Thu, 30 Nov 2000 06:55:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:264 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S130509AbQK3Luw>;
        Thu, 30 Nov 2000 06:50:52 -0500
Date: Thu, 30 Nov 2000 12:20:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12-pre3 -- Playing an audio CD halts with drive errors.
Message-ID: <20001130122019.A31057@suse.de>
In-Reply-To: <3A25F803.6090609@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A25F803.6090609@megapathdsl.net>; from miles@megapathdsl.net on Wed, Nov 29, 2000 at 10:47:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2000, Miles Lane wrote:
> This could be a CD scratch, but I don't think it is.
> This is a brand new CD which I just opened.
> 
> After the errors from /var/log/messages, I include
> info from hdparm -g -i.
> 
> hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: packet command error: error=0x50
> ATAPI device hdc:
>    Error: Illegal request -- (Sense key=0x05)
>    Invalid field in command packet -- (asc=0x24, ascq=0x00)
>    The failed "Play Audio MSF" packet command was:
>    "47 00 00 00 02 00 3f 24 ff 00 00 00 "
>    Error in command packet byte 8 bit 0

Try with

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2

It should apply cleanly to test12-pre3 too.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

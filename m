Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130861AbQK3TYw>; Thu, 30 Nov 2000 14:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130882AbQK3TYD>; Thu, 30 Nov 2000 14:24:03 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:25615 "EHLO
        smtp.lax.megapath.net") by vger.kernel.org with ESMTP
        id <S130792AbQK3TXn>; Thu, 30 Nov 2000 14:23:43 -0500
Message-ID: <3A26A1B5.9050203@megapathdsl.net>
Date: Thu, 30 Nov 2000 10:51:33 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12-pre3 -- Playing an audio CD halts with drive errors.
In-Reply-To: <3A25F803.6090609@megapathdsl.net> <20001130122019.A31057@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Try with
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2
> 
> It should apply cleanly to test12-pre3 too.

Thanks Jens.

Your patch enables me to play the entire CD.
However, I still get this error every time
I begin playing the CD:

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x50
ATAPI device hdc:
   Error: Illegal request -- (Sense key=0x05)
   Invalid field in command packet -- (asc=0x24, ascq=0x00)
   The failed "Play Audio MSF" packet command was:
   "47 00 00 00 02 00 3f 24 ff 00 00 00 "
   Error in command packet byte 8 bit 0
Play from track 1 to 9
lba 0 to lba 286050

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

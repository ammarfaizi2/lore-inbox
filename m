Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130969AbRA0T2W>; Sat, 27 Jan 2001 14:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135271AbRA0T2M>; Sat, 27 Jan 2001 14:28:12 -0500
Received: from marks-43.caltech.edu ([131.215.92.43]:31751 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S130969AbRA0T15>; Sat, 27 Jan 2001 14:27:57 -0500
Date: Sat, 27 Jan 2001 11:26:54 -0800 (PST)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: Jens Axboe <axboe@suse.de>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
In-Reply-To: <20010127141730.C27929@suse.de>
Message-ID: <Pine.LNX.4.32.0101271121070.1098-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I gave it a whirl.  Sadly, no change.

On Sat, 27 Jan 2001, Jens Axboe wrote:
> My gut tells me that this is the 'get last written' command, and even
> with the quiet flag we get the IDE error status printed. Could you
> try and add
>
> 	goto use_toc;
>
> add the top of drivers/cdrom/cdrom.c:cdrom_get_last_written() and
> see if that makes the error disappear?

-Jacob

-- 

Reechani, Sentrosi, Vasi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

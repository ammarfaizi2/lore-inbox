Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132287AbRA0Itt>; Sat, 27 Jan 2001 03:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132282AbRA0Itj>; Sat, 27 Jan 2001 03:49:39 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:58891
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132166AbRA0Itb>; Sat, 27 Jan 2001 03:49:31 -0500
Date: Sat, 27 Jan 2001 00:48:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: jacob@chaos2.org
cc: linux-kernel@vger.kernel.org
Subject: Re: hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
In-Reply-To: <Pine.LNX.4.21.0101252046320.13852-100000@inbetween.blorf.net>
Message-ID: <Pine.LNX.4.10.10101270047200.23960-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Jacob Luna Lundberg wrote:

> 
> I've been getting this during the boot sequence for quite some time now.
> They don't seem to impact the functionality of the drive any though.  Just
> another extra-verbose kernel message I should ignore?  :)
> 
> (This is from the 2.4.1-pre10 btw.)
> 
> hdd: CD-ROM TW 120D, ATAPI CD/DVD-ROM drive
> hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hdd: set_drive_speed_status: error=0x04

Means your device did not like that command and barfed.
status=0x51, error=0x04 == command aborted next....

> [...]
> hdd: ATAPI 12X CD-ROM drive, 240kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> 
> -Jacob
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

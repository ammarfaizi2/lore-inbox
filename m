Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWBMMAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWBMMAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWBMMAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:00:24 -0500
Received: from lucidpixels.com ([66.45.37.187]:32190 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932069AbWBMMAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:00:23 -0500
Date: Mon, 13 Feb 2006 07:00:22 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Re: Is my SATA/400GB drive dying?
In-Reply-To: <Pine.LNX.4.64.0602130658110.21652@p34>
Message-ID: <Pine.LNX.4.64.0602130659420.21772@p34>
References: <Pine.LNX.4.64.0602130658110.21652@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are different errors at the end of the lines:

0xb/00/00 and 0x3/11/04

Anyone know what these mean?

[31230.223511] ata6: status=0x51 { DriveReady SeekComplete Error }
[31230.223515] ata6: error=0x04 { DriveStatusError }
[37209.844015] ata6: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[37209.844022] ata6: status=0x51 { DriveReady SeekComplete Error }
[37209.844026] ata6: error=0x04 { DriveStatusError }
[37861.648959] ata6: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[37861.648965] ata6: status=0x51 { DriveReady SeekComplete Error }
[37861.648970] ata6: error=0x04 { DriveStatusError }
[37978.030178] ata6: no sense translation for status: 0x51
[37978.030185] ata6: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 
0x3/11/04
[37978.030188] ata6: status=0x51 { DriveReady SeekComplete Error }


On Mon, 13 Feb 2006, Justin Piszcz wrote:

> I turned off smartd and when I cat /dev/zero > /mnt/disk/file, I get the 
> following errors:
>
> [37978.030178] ata6: no sense translation for status: 0x51
> [37978.030185] ata6: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 
> 0x3/11/04
> [37978.030188] ata6: status=0x51 { DriveReady SeekComplete Error }
>
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbUAPHkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUAPHkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:40:06 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265297AbUAPHkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 02:40:02 -0500
Date: Fri, 16 Jan 2004 07:47:49 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
To: Jonathan Kamens <jik@kamens.brookline.ma.us>, linux-kernel@vger.kernel.org
In-Reply-To: <16391.24288.194579.471295@jik.kamens.brookline.ma.us>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
 <16389.63781.783923.930112@jik.kamens.brookline.ma.us>
 <16391.24288.194579.471295@jik.kamens.brookline.ma.us>
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
> The drive which stopped reporting BadCRC errors for weeks when I
> transferred it from the Promise PDC20262 Ultra66 controller to the
> SIIG SIi680 Ultra133 controller just reported this:
> 
> Jan 15 22:03:13 jik kernel: hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Jan 15 22:03:13 jik kernel: hde: drive_cmd: error=0x04 { DriveStatusError }
> Jan 15 22:03:20 jik kernel: hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Jan 15 22:03:20 jik kernel: hde: drive_cmd: error=0x04 { DriveStatusError }

The drive doesn't seem to understand the command it was sent.

> I don't know whether it's relevant that these errors are tagged
> "drive_cmd" and the BadCRC errors were tagged "dma_intr".
> 
> Are the errors above close enough to the BadCRC errors I was getting,
> i.e.:
> 
>   hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>   hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> for me to now start suspecting a problem with the drive, given that
> two different controllers with two different chipsets are reporting
> problems with it?

No.

John.

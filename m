Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269913AbRHJEdC>; Fri, 10 Aug 2001 00:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269907AbRHJEcw>; Fri, 10 Aug 2001 00:32:52 -0400
Received: from lpce015.lss.emc.com ([168.159.62.15]:16900 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269905AbRHJEck>; Fri, 10 Aug 2001 00:32:40 -0400
Date: Thu, 9 Aug 2001 22:31:46 -0600
Message-Id: <200108100431.f7A4VkG01068@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs, scsi_debug
In-Reply-To: <3B735FCF.E197DD5B@torque.net>
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
	<3B735FCF.E197DD5B@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert writes:
> This is a multi-part message in MIME format.

Yuk! MIME!
> $ ls -l /devfs/scsi/host46/bus0/target0/lun0/*
> brw-------    1 root     root     114,  16 Dec 31  1969
>                         /devfs/scsi/host46/bus0/target0/lun0/disc
> brw-------    1 root     root     114,  17 Dec 31  1969
>                         /devfs/scsi/host46/bus0/target0/lun0/part1
> brw-------    1 root     root     114,  18 Dec 31  1969
>                         /devfs/scsi/host46/bus0/target0/lun0/part2
> brw-------    1 root     root     114,  19 Dec 31  1969
>                         /devfs/scsi/host46/bus0/target0/lun0/part3
> 
> Note the large major device number that devfs is pulling
> from the unused pool. Devfs makes some noise when
> 'rmmod scsi_debug' is executed but otherwise things looked
> ok.

What was the message?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130218AbRAQW1O>; Wed, 17 Jan 2001 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbRAQW1E>; Wed, 17 Jan 2001 17:27:04 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:52098 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130449AbRAQW0z>; Wed, 17 Jan 2001 17:26:55 -0500
Message-ID: <3A661C12.22271291@Home.net>
Date: Wed, 17 Jan 2001 17:26:26 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [DISCUSSION]: 2.4.1-pre8: Detection of CD-ROM/CD-R/CD-RW drives Part 
 #2
In-Reply-To: <3A661B21.6BC31670@Home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.18 and below:

Jan  5 16:56:54 coredump kernel: hdc: YAMAHA CRW2100E, ATAPI CDROM drive
Jan  5 16:56:54 coredump kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive,
8192kB Cache, (U)DMA

2.4.x:

Jan 15 19:43:05 coredump kernel: hdc: YAMAHA CRW2100E, ATAPI CDROM drive
Jan 15 19:43:06 coredump kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive,
8192kB Cache, (U)DMA


the standard ATAPI detects this correctly.

Shawn Starr wrote:

> In 2.4.1-pre8, this info appears in dmesg:
>
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0H
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>
> hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
>
> This model isn't DVD ;)
>
> It's a CD-ROM/CD-R/RW drive 8MB cache 40x read, as detected by the
> standard ATAPI drivers. the SCSI emulation doesnt appear to detect the
> right kind of drive (its assuming its a CD-ROM only?)
>
> Shawn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSASOuP>; Sat, 19 Jan 2002 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSASOuF>; Sat, 19 Jan 2002 09:50:05 -0500
Received: from intbg-piocommers.internet-bg.net ([212.124.67.90]:11733 "HELO
	ns.top.bg") by vger.kernel.org with SMTP id <S282843AbSASOt4>;
	Sat, 19 Jan 2002 09:49:56 -0500
Message-ID: <3C4A1475.4D0BB1F6@top.bg>
Date: Sat, 19 Jan 2002 16:51:01 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sharing Interrupt+HPT366 Problem on BP6
In-Reply-To: <3C49A8AD.2BBC7F7A@top.bg> <20020119112555.GD135220@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without NIC hangs too...
I tried every combination that i can imagine and the result is:
Drives on only one channel - system works
Drives on both channels - system hangs

Ville Herva wrote:

> On Sat, Jan 19, 2002 at 09:11:09AM -0800, you [Anton Tinchev] claimed:
> >
> > The configuration is:
> > Abit BP6 MB
> > Single Celeron 366 processor
> > 1X10G hdd
> > 3X60G hdd
> > 256MB ram
> > Davicom 100MB/s NIC
> > S3 Trio3D AGP VGA
>
> Which slot did you put your nic (and other pci cards)? Don't put them in
> slot #3 (it shares the IRQ with HPT366). And even if slot 3 is empty, try
> switching the slow and see if it makes difference.
>
> Also, make sure you have the newest bios.
>
> I have BP6 here, three drives HPT366:
>
> hda: IBM-DCAA-34330, ATA DISK drive
> hdb: CD-532E-A, ATAPI CD/DVD-ROM drive
> hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
> hde: IBM-DJNA-352030, ATA DISK drive
> hdf: IBM-DTTA-351680, ATA DISK drive
> hdg: SAMSUNG SV6004H, ATA DISK drive
> hdh: SAMSUNG SV6004H, ATA DISK drive
>
> No problems.
>
> -- v --
>
> v@iki.fi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290936AbSASL0j>; Sat, 19 Jan 2002 06:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290937AbSASL0S>; Sat, 19 Jan 2002 06:26:18 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:41898 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S290936AbSASL0M>; Sat, 19 Jan 2002 06:26:12 -0500
Date: Sat, 19 Jan 2002 13:25:55 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Anton Tinchev <atl@top.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sharing Interrupt+HPT366 Problem on BP6
Message-ID: <20020119112555.GD135220@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Anton Tinchev <atl@top.bg>, linux-kernel@vger.kernel.org
In-Reply-To: <3C49A8AD.2BBC7F7A@top.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C49A8AD.2BBC7F7A@top.bg>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 09:11:09AM -0800, you [Anton Tinchev] claimed:
> 
> The configuration is:
> Abit BP6 MB
> Single Celeron 366 processor
> 1X10G hdd
> 3X60G hdd
> 256MB ram
> Davicom 100MB/s NIC
> S3 Trio3D AGP VGA

Which slot did you put your nic (and other pci cards)? Don't put them in
slot #3 (it shares the IRQ with HPT366). And even if slot 3 is empty, try
switching the slow and see if it makes difference.

Also, make sure you have the newest bios.

I have BP6 here, three drives HPT366:

hda: IBM-DCAA-34330, ATA DISK drive
hdb: CD-532E-A, ATAPI CD/DVD-ROM drive
hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
hde: IBM-DJNA-352030, ATA DISK drive
hdf: IBM-DTTA-351680, ATA DISK drive
hdg: SAMSUNG SV6004H, ATA DISK drive
hdh: SAMSUNG SV6004H, ATA DISK drive

No problems.


-- v --

v@iki.fi

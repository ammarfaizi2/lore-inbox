Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbSJVMWd>; Tue, 22 Oct 2002 08:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJVMWd>; Tue, 22 Oct 2002 08:22:33 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:60032 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262478AbSJVMWc> convert rfc822-to-8bit; Tue, 22 Oct 2002 08:22:32 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: PCMCIA cardmgr kill hangs kernel
Date: Tue, 22 Oct 2002 14:20:59 +0200
User-Agent: KMail/1.4.7
Cc: bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210221046.46700.Take.Vos@binary-magic.com> <200210221313.49423.Take.Vos@binary-magic.com> <1035288939.31917.57.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1035288939.31917.57.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221421.09375.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 22 October 2002 14:15, Alan Cox wrote:
> On Tue, 2002-10-22 at 12:13, Take Vos wrote:
> > removing the flashcard from the pcmcia slot also hangs the kernel.
> > So it seams a flashcard issue (I had issues with this card in the early
> > 2.4.x kernels, but it would hang the kernel at insertion)
>
> IDE card eject was broken in the new IDE code but should have been
> fixed, unless it has come broken again. I'll investigate at some point
> soon
issue remains in 2.5.44, I haven't have a change to check other pcmcia cards, 
because I have none

flashcard as reported by 2.4.19 kernel:
	hdc: SunDisk SDCFB-2, ATA DISK drive
	ide2: ports already in use, skipping probe
	ide1 at 0x100-0x107,0x10e on irq 3
	hdc: 3936 sectors (2 MB) w/1KiB Cache, CHS=123/2/16
	/dev/ide/host1/bus0/target0/lun0:hdc: set_geometry_intr: status=0x51 { 
DriveReady SeekComplete Error }
	hdc: set_geometry_intr: error=0x04 { DriveStatusError }
	 p1
	ide_cs: hdc: Vcc = 3.3, Vpp = 0.0





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tUKvMMlizP1UqoURAilpAJ9ChjCZbzz4TtFgaxfZ1ewfiw5JFQCfcvw9
Mat3Z0rQ/dOKsEEay/DC83Q=
=/XEj
-----END PGP SIGNATURE-----


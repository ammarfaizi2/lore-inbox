Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270905AbRICRk0>; Mon, 3 Sep 2001 13:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270821AbRICRkR>; Mon, 3 Sep 2001 13:40:17 -0400
Received: from [209.38.98.99] ([209.38.98.99]:24757 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S270800AbRICRj7>;
	Mon, 3 Sep 2001 13:39:59 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Fred <fred@arkansaswebs.com>
To: =?iso-8859-1?q?J=F6rn=20Nettingsmeier?= 
	<nettings@folkwang-hochschule.de>
Subject: Re: 2.4.8-ac11 lockup when burning cds
Date: Mon, 3 Sep 2001 12:40:05 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B922604.A8E3EB5F@folkwang-hochschule.de> <01090216434100.01174@bits.linuxball> <3B9392D8.BC963F23@folkwang-hochschule.de>
In-Reply-To: <3B9392D8.BC963F23@folkwang-hochschule.de>
MIME-Version: 1.0
Message-Id: <01090312400502.21988@bits.linuxball>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read quite a few messages about SMP machines locking up.
I believe that a few patches are available for these things, but you'd have 
to go back to the archive to find out more.

Fred

 _________________________________________________ 
On Monday 03 September 2001 09:25 am, Jörn Nettingsmeier wrote:
> Fred wrote:
> > burning on 2.4.9-ac5 works fine for me with
> > amd 500
> > 12x ide cdrw
> > 256MB ram
> > ali mainboard
> >
> > what's your hardware config?
>
> #cdrecord -scanbus
> Cdrecord 1.9 (i686-suse-linux) Copyright (C) 1995-2000 Jörg
> Schilling
> Linux sg driver version: 3.1.20
> Using libscg version 'schily-0.1'
> scsibus0:
>         0,0,0     0) 'IBM     ' 'DCAS-34330W     ' 'S65A' Disk
>         0,2,0     2) 'TOSHIBA ' 'CD-ROM XM-6201TA' '1037' Removable
> CD-ROM
> scsibus2:
>         2,0,0   200) 'PHILIPS ' 'CDD3610 CD-R/RW ' '2.02' Removable
> CD-ROM
>
> there is another pci scsi adaptor (a symbios) for my scanner, but i
> only load the module on demand, and it wasn't loaded when the lockup
> occured.
>
> i see you are running UP, perhaps it's a SMP related problem ?
>
> will try playing with some debug options and linus' release...

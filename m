Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292774AbSBZUHZ>; Tue, 26 Feb 2002 15:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292776AbSBZUHW>; Tue, 26 Feb 2002 15:07:22 -0500
Received: from out005slb.verizon.net ([206.46.170.17]:32162 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP
	id <S292777AbSBZUGx>; Tue, 26 Feb 2002 15:06:53 -0500
Date: Tue, 26 Feb 2002 15:05:39 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Simon Turvey <turveysp@ntlworld.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE error on 2.4.17
Mail-Followup-To: Simon Turvey <turveysp@ntlworld.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fmJt-0001Xi-00@the-village.bc.nu> <006e01c1bef6$6dd78e40$030ba8c0@mistral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <006e01c1bef6$6dd78e40$030ba8c0@mistral>; from turveysp@ntlworld.com on Tue, Feb 26, 2002 at 06:50:15PM -0000
Message-Id: <20020226200631.YXHW5018.out005.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Simon Turvey wrote:
> The drive's less than a year old :-(
> 
> Should I try disabling some of the UDMA stuff?
> 
> ----- Original Message ----- 
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> To: "Simon Turvey" <turveysp@ntlworld.com>
> Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
> Sent: Tuesday, February 26, 2002 6:27 PM
> Subject: Re: IDE error on 2.4.17
> 
> 
> > > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > > hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
> > > sector=250680
> > > end_request: I/O error, dev 03:01 (hda), sector 250680
> > 
> > Uncorrectable error is a message from your disk, along the lines of "Hey
> > pal I wonder if the warranty has expired yet"

I've seen 2 drives with UncorrectableErrors that were correctable.

One happened after booting Linux with APM enabled, and the other after
running Windows with vendor-specific DMA Block mode enabled.

In each case a low level format took care of it.  No bad sectors on
either drive in over a year.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjx76nUACgkQBMKxVH7d2wpW4wCg+MQQBIOZfHRqR0QKUhNbuFSB
kkIAoK/ThQ/pIeoj3/Qu8ZAd6S26E8M/
=/bRM
-----END PGP SIGNATURE-----

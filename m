Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSD0P3Q>; Sat, 27 Apr 2002 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314258AbSD0P3P>; Sat, 27 Apr 2002 11:29:15 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:56230 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S314243AbSD0P3O>; Sat, 27 Apr 2002 11:29:14 -0400
Date: Sat, 27 Apr 2002 09:29:03 -0600
Message-Id: <200204271529.g3RFT3413819@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tanner@real-time.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
In-Reply-To: <E171U2U-0008Pv-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Dual (2) AMD ATHLON MP 1900+ CPUs
> > ASUA7M266D Motherboard
> 
> Either update the BIOS or set it to MP1.1

Which BIOS version was the problem found on? I've got one of these,
and the original 1004 Award BIOS didn't give this problem, nor does
the 1005A BIOS I upgraded to.

However, I am having memory problems. Anyone else got similar
experiences (or good experiences)? I got 3 of 1 GiB DDR266 ECC Reg
DIMMs (36 chips apiece) and a 512 MiB DDR266 ECC Unbuf DIMM (18
chips). I have various problems:

- none of the DIMMs are reported by the BIOS as ECC, whether plugged
  in together or separately

- plugging in one 1 GiB DIMM will sometimes yield a bit error with
  memtest86 test #1

- plugging in two 1 GiB DIMMs will yield a bit error in test #1

- plugging in three 1 GiB DIMMs will yield a stream of bit errors in
  test #1 (and possibly other tests, but I gave up before then).

The vendor claims the 1 GiB DIMMs are compatible with the A7M266-D,
but when I received the M/B and DIMMs, I noted the motherboard manual
said it only supported DIMMs with up to 18 chips each, and of course
the 1 GiB DIMMs have 36 chips each :-(

According to Asus tech support 18 chip 1 GiB DIMMs are not available
yet. When I asked why they claimed support for 1 GiB DIMMs, they said
"for the future". Argh! Anybody know if 18 chip 1 GiB DDR DIMMs are
available anywhere?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUAYJe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 04:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUAYJe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 04:34:27 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:24801 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S263834AbUAYJeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 04:34:24 -0500
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Status of Athlon 64 K8V-D support was (Re: Strange pauses in 2.6.2-rc1 / AMD64)
Date: Sun, 25 Jan 2004 10:34:09 +0100
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0401212107010.24057-100000@www.princetongames.org> <200401241505.40566.stephanm@muc.de> <40124B47.9040505@yahoo.com>
In-Reply-To: <40124B47.9040505@yahoo.com>
Cc: Brandon Ehle <azverkan@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_U24EAZfr3hfQnNK";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251034.12073.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_U24EAZfr3hfQnNK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 24 January 2004 11:39, you wrote:
> Stephan Maciej wrote:
> > On Friday 23 January 2004 03:42, Brandon Ehle wrote:
> >>This is on a Athlon 64 3000+ on a K8V Deluxe, 1GB RAM, Gentoo for x86_6=
4.
> >
> > Hi,
> >
> > I am playing with the idea of getting exactly this HW config in the near
> > future. I haven't found much user reports concerning running Linux -
> > possibly Gentoo - on such a system (Athlon64 on an K8V-D mobo). Do your
> > SATA controllers work, esp. when booting an AMD64 kernel? How's the rest
> > of the on-board hardware behaving? Is it all working? What memory brand
> > did you buy?
> >
> > Thanks a lot in advance,
> >
> > Stephan
>
> First off, I'm only running the 2.6 kernel and haven't even tried the
> 2.4 kernel on this board.
>
> The board comes with 2 software RAID SATA controllers in addition to the
> PATA ones.  I've only gotten one of the two SATA controllers (VIA) to
> work, and I'm not using RAID (just a single 10,000RPM drive).  I believe
> Gentoo's gentoo-dev-sources kernel has a driver for the other controller
> (Promise FastTrak 378), but I haven't tried it yet because I'm already
I currently use an IBM/Hitachi-SATA-drive attached to the Promise-Controlle=
r=20
on the K8V-D without problems. I use the Promise-driver from the SATA=20
support. The controller is configured to work as a plain IDE-Controller.
Kernels I tried are 2.6.1 and 2.6.2-rc1-mm2.

> reaching the peak of the drive with the controller I have working.  One
> thing to note is that the harddrive does run about 20% slower in x86_64
> kernels currently, but I'm not sure why that is.
Haven't tried 64bit-support yet ...

>
> I went with 2 matched sticks of Geil DDR433 512MB (PC-3500), but one of
> the weird things about the board is that if I use the other 2 memory
> slots (4 in total), the RAM will only go DDR333 instead of DDR400 (I
> picked DDR433 in case I want to try overclocking someday).  I'm not sure
> if that's specific to this board or if all of them have that problem
> (due to the onchip memory controller).
>
> The onboard 1000MB 3COM card (sk98lin driver) is pretty typical of all
> 3COM cards and fails under extremely high load cases (I've never used a
> 3COM card that didn't fail under my high load conditions), so I'm using
> a second PCI 100MB NIC (tulip driver) to talk to my high load device and
> the 1GB for my Internet connection.  I don't think it is the sk98lin
> driver at fault because the card takes a nosedive under high load
> conditions in Win2K too (reaching the theorhetical peak of the card).
>
> I don't use the onboard sound as I have an Audigy 2 (OSS driver, ALSA
> doesn't work), so I don't know anything about that.  All 8 USB ports
> (uhci-hcd driver) work fine.  I don't have any firewire devices, but it
> finds the port ok.  For video I'm running a GeForce FX 5900 Ultra
> (nvidia proprietary) and that works good too (using the amd640-agp driver=
).
>
> Everything hardware seems to work equally well in x86 or x86_64 mode,
> but I'm not running in x86_64 mode anymore because of all the userspace
> problems.  The only issue I ran into when going to x86_64 was needing to
> turn off "Legacy USB Support" in the BIOS so I didn't have to pass
> idle=3Dpoll on the command line which then stops me from getting the 3-5
> second pauses when compiling or running benchmarks.
>
> Gentoo was my choice of OS for x86_64 mode because none of the other
> distributions have a decent sized package set for x86_64 yet, but I've
> fallen back to debian-unstable (for better stability!) until more
> packages support x86_64.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-02=_U24EAZfr3hfQnNK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAE42U4q3E2oMjYtURAvVeAJ4qB9/cUNTV4Bz5GR6WiSz3XSmiAgCfYijU
fGz2HaYPoEnUh0dJuZ+YukY=
=MiP/
-----END PGP SIGNATURE-----

--Boundary-02=_U24EAZfr3hfQnNK--

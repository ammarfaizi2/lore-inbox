Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRFHIKE>; Fri, 8 Jun 2001 04:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263924AbRFHIJy>; Fri, 8 Jun 2001 04:09:54 -0400
Received: from kaiser.cip.physik.uni-muenchen.de ([141.84.136.1]:7941 "EHLO
	kaiser.cip.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S263923AbRFHIJm>; Fri, 8 Jun 2001 04:09:42 -0400
Date: Fri, 8 Jun 2001 10:09:29 +0200 (CEST)
From: "Andreas K. Huettel" <Andreas.Huettel@Physik.Uni-Muenchen.DE>
Reply-To: "Andreas K. Huettel" <andreas@akhuettel.de>
To: linux-kernel@vger.kernel.org
Subject: probable hardware bug: clock timer ... (Asus board)?!?
Message-ID: <Pine.LNX.4.21.0106080958380.8127-100000@ankogel.cip.physik.uni-muenchen.de>
X-Information: My public GPG key can be obtained at http://www.akhuettel.de/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear kernel specialists, 

Jun  8 03:00:39 qubit kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Jun  8 03:00:39 qubit kernel: probable hardware bug: restoring chip
configuration.

can anybody please tell me what is the exact _impact_ of this problem? I
get these messages on an idle machine with Asus A7A266 motherboard (not
VIA) (planned nfs server) about every 2-5 minutes. Kernel 2.2.18 as
shipped with SuSE 7.1 (k_default).

- From code snippets I have seen, this means the clock is jumping
around?!? Has anybody found a way to get rid of this problem?
(Yes, I know, this has been discussed before, but I did not see any
resolution). For /proc/pci see below, if you need any more info, feel free
to contact me. 

best regards, Andreas

/proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Labs Unknown device (rev 4).
      Vendor id=10b9. Device id=1647.
      Medium devsel.  Master Capable.  No bursts.  
      Prefetchable 32 bit memory at 0xf0000000 [0xf0000008].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Labs Unknown device (rev 0).
      Vendor id=10b9. Device id=5247.
      Slow devsel.  Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   2, function  0:
    USB Controller: Acer Labs M5237 USB (rev 3).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe5800000 [0xe5800000].
  Bus  0, device   6, function  0:
    USB Controller: Acer Labs M5237 USB (rev 3).
      Medium devsel.  Fast back-to-back capable.  IRQ 5.  Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe4800000 [0xe4800000].
  Bus  0, device   4, function  0:
    IDE interface: Acer Labs M5229 TXpro (rev 196).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xd400 [0xd401].
  Bus  0, device   5, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 16).
      Vendor id=13f6. Device id=111.
      Medium devsel.  IRQ 9.  Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd000 [0xd001].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Labs M1533 Aladdin IV (rev 0).
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com Unknown device (rev 116).
      Vendor id=10b7. Device id=9200.
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xb400 [0xb401].
      Non-prefetchable 32 bit memory at 0xe3800000 [0xe3800000].
  Bus  0, device  17, function  0:
    Bridge: Acer Labs M7101 PMU (rev 0).
      Medium devsel.  
  Bus  1, device   0, function  0:
    VGA compatible controller: NVidia Unknown device (rev 161).
      Vendor id=10de. Device id=110.
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6000000].
      Prefetchable 32 bit memory at 0xe8000000 [0xe8000008].


- ---------------------------------------------------------------------
Andreas K. Huettel          andreas@akhuettel.de
81627 Muenchen              huettel@qubit.org
Germany                     http://www.akhuettel.de/
- ---------------------------------------------------------------------  
Please use GNUPG or PGP for signed and encrypted email. My public key 
can be found at http://www.akhuettel.de/pgp_key.html
- ---------------------------------------------------------------------  

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE7IIhAL+gLs3iH94cRAsVtAJjKH8CEREWT/mab/paavB6DrWyNAKCNqydJ
FqEMm4yzHp8JBHn3Ek8HOw==
=MfLW
-----END PGP SIGNATURE-----



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUAFJjd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUAFJjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:39:33 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:55748 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261735AbUAFJjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:39:31 -0500
Date: Tue, 6 Jan 2004 10:39:26 +0100
From: martin f krafft <madduck@madduck.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem booting aic7xxx-old with reiserfs
Message-ID: <20040106093926.GA5904@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1aMb6-3Fs-37@gated-at.bofh.it> <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at> <20040106084728.GA3094@piper.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20040106084728.GA3094@piper.madduck.net>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2004.01.06.0947 +0100]:
> I tried that, but at first, the driver spat out thousands of lines
> of errors before the kernel failed to mount the root filesystem, and
> then upon reboot, I still got various errors related to SCSI. When
> I looked in the description of the aic7xxx drivers, I only found the
> 294x covered by the old driver.

I tried the new driver again, and there were no thousand lines.
However, I did get error messages:

  scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
          <Adaptec 2940 Ultra SCSI adapter>
          aic7880: Ultra Single Channel A, SCSI Id=3D7, 16/253 SCBs

  scsi0:A:0:0: DV failed to configure device.  Please file a bug report aga=
inst th
  is driver.
  (scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
  (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
    Vendor: QUANTUM   Model: FIREBALL ST4.3S   Rev: 0F0C
    Type:   Direct-Access                      ANSI SCSI revision: 02
  scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
    Vendor: NEC       Model: CD-ROM DRIVE:465  Rev: 1.03
    Type:   CD-ROM                             ANSI SCSI revision: 02
    Vendor: PHILIPS   Model: CDD2600           Rev: 1.07
    Type:   CD-ROM                             ANSI SCSI revision: 02
  SCSI device sda: 8519216 512-byte hdwr sectors (4362 MB)
  SCSI device sda: drive cache: write through
  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  sr0: scsi3-mmc drive: 14x/32x cd/rw xa/form2 cdda tray
  Uniform CD-ROM driver Revision: 3.12
  Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
  sr1: scsi-1 drive
  Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
  Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 5
  Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 5

It says I should file a bug report. First, I'd like to investigate
this on this mailing list.

Do you have a clue what this is about? The system seems to boot
fine, and it appears to be working.

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"when in doubt, parenthesize. at the very least it will let some
 poor schmuck bounce on the % key in vi."
                                                         -- larry wall

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+oJOIgvIgzMMSnURAiwGAKCxdq7XeHt+4Sk7XPoJVab1Afl0bgCg142J
uB+T9akUqlWO0oSwta6sURU=
=WByD
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTBPQOf>; Sun, 16 Feb 2003 11:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbTBPQOf>; Sun, 16 Feb 2003 11:14:35 -0500
Received: from mx.laposte.net ([213.30.181.7]:25289 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id <S267309AbTBPQOd>;
	Sun, 16 Feb 2003 11:14:33 -0500
Subject: Alsa kernel questionS
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ucgQpwbInmeADcU4Sdse"
Organization: 
Message-Id: <1045412663.1955.10.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 16 Feb 2003 17:24:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ucgQpwbInmeADcU4Sdse
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	I've got a Hercules Fortissimo III 7.1 :

00:0a.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: Hercules Fortissimo III 7.1
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e9100000 (32-bit, non-prefetchable)
[size=3D4K]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable)
[size=3D1M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=09

I use it *only* via the optical output.

Now it seems the alsa driver that's in 2.5 with mute the optical output
until black magic is performed in any alsa-compatible mixer.

Is there any boot option to tell alsa to activate the optical output
automatically ?

The second question is, with the alsa tools present on freshrpms.net and
optical output activated, the only mixer setting that seem to have an
effect is the DAC.

Is there a way to set this knob as the default sound volume (as a kernel
boot option ...) ?

Why is the dac controlling the volume even when I'm reading a CD (i.e.
digital PCM input, digital optical output, what is the DAC doing here) ?

Sorry about the stupid questions, I found lots of material on building
alsa (not really needed now it's in-kernel) but little on how to use
it:(

Regards,

--=20
Nicolas Mailhot

--=-ucgQpwbInmeADcU4Sdse
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+T7s3I2bVKDsp8g0RAtDuAJ91qDZcA032hqPnjkmzGNcXtDrewgCgpVZK
xdKccYywx2aJfOs37j9x/IM=
=tb83
-----END PGP SIGNATURE-----

--=-ucgQpwbInmeADcU4Sdse--


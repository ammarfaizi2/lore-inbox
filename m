Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTDPKTO (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTDPKTO 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:19:14 -0400
Received: from [195.167.170.152] ([195.167.170.152]:53918 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S264286AbTDPKTM 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 06:19:12 -0400
Date: Wed, 16 Apr 2003 11:31:05 +0100
From: Athanasius <link@gurus.tf>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.21-pre7-ac1] IDE Warning when booting
Message-ID: <20030416103105.GC7135@miggy.org>
Mail-Followup-To: Athanasius <link@gurus.tf>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <b7jahc$8f0$1@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <b7jahc$8f0$1@tangens.hometree.net>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2003 at 10:16:12AM +0000, Henning P. Schmiedehausen wrote:
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

   Not the exact, byte-for-byte, same, but, from Configure.help:

CONFIG_IDEDISK_MULTI_MODE
  If you get this error, try to say Y here:

  hda: set_multmode: status=3D0x51 { DriveReady SeekComplete Error }
  hda: set_multmode: error=3D0x04 { DriveStatusError }

  If in doubt, say N.

Do you have that option enabled or not?

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6dMOkACgkQIr2uvLNOS8PgXQCfftxVC+tzUL3lKq2Ky0+1M7AT
5/8An0+52qDuLQstRJJdzVjus9to9YWN
=aPzk
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130805AbQK3Cwh>; Wed, 29 Nov 2000 21:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132614AbQK3CwD>; Wed, 29 Nov 2000 21:52:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25107 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S130132AbQK3Cvy>;
        Wed, 29 Nov 2000 21:51:54 -0500
Date: Thu, 30 Nov 2000 02:01:47 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs mount 2x, umount 1x
Message-ID: <20001130020146.B3564@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A25A39F.3162018E@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A25A39F.3162018E@intel.com>; from randy.dunlap@intel.com on Wed, Nov 29, 2000 at 04:47:27PM -0800
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2000 at 04:47:27PM -0800, Randy Dunlap wrote:
>=20
> Summary:  After I mount usbdevfs 2 times, and umount it
> 1 time, the usbcore module use count prevents it from
> being rmmod-ed.

> [root@dragon rdunlap]# lsmod
> usbcore                50656   2  [uhci]

> and 'mount' shows no usb or usbdevfs entries listed.

Are there usbdevfs entries in /proc/mount? Maybe 'umount' removes
too many entries from /etc/mtab...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjolpvoACgkQHb1edYOZ4bssvwCfcx2iUAO+DnmZKmwk9Uz3prDg
nvsAnj5PNS3CJ/tGahHQ7nRYOXdCsXBN
=iKaZ
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

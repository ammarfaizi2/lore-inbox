Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVLFOiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVLFOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVLFOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:38:16 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:10946 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751464AbVLFOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:38:15 -0500
Date: Tue, 6 Dec 2005 20:40:47 +0530
From: Harald Welte <laforge@gnumonks.org>
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Jiri Benc <jbenc@suse.cz>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051206151046.GF4038@rama.exocore.com>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <4394902C.8060100@pobox.com> <20051205195329.GB19964@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <20051205195329.GB19964@redhat.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2005 at 02:53:29PM -0500, Dave Jones wrote:
>  > ieee80211 is used by Intel.  Some bits used by HostAP, which also=20
>  > duplicates a lot of ieee80211 code.  And bcm43xx.  And another couple=
=20
>  > drivers found in -mm or out-of-tree.
>=20
> Orinoco also uses it now no ?

Dave, the Orinoco is a wireless card that has a hardware MAC, plust
firmware.=20

I do agree with Jiri that there basically is no support for softmac
devices in the ieee80211 code.

I'm also in favor of merging the devicescape code, but I don't see it
happening without somebody taking care to provide all the required
levels of interfaces (I see at least three levels of API's that a wireless
driver would need, depending on how much stuff is done in
hardware/firmware and how much in software.

I also think that there is a lack of knowledge on the architecture of
802.11 low-level protocols and drivers among many people (including
myself) in the network community.  Only this way I can explain why there
are always people who claim that the kernel already has a 802.11
'stack'.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlan2XaXGVTD0i/8RAiXLAJ0bjeV0IhrVI4ti5dItgTFrxH7g8ACfYlYN
Y8K8p/wXfSshWhMYLApvyFA=
=d9HG
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--

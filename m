Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWEIANM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEIANM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 20:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWEIANM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 20:13:12 -0400
Received: from hs-grafik.net ([80.237.205.72]:7441 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1750835AbWEIANL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 20:13:11 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Joe Feise <jfeise@feise.com>
Subject: Re: reiser4 bug [was Re: 2.6.17-rc3-mm1]
Date: Tue, 9 May 2006 02:13:03 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net> <200605082246.50332@zodiac.zodiac.dnsalias.org> <20060508232159.13550.qmail@pv105234.reshsg.uci.edu>
In-Reply-To: <20060508232159.13550.qmail@pv105234.reshsg.uci.edu>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1648581.UYTTP183aE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605090213.06693@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1648581.UYTTP183aE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nope, did not work...
regards
Alex

Am Dienstag, 9. Mai 2006 01:21 schrieb Joe Feise:
> Try the patch from here:
> http://marc.theaimsgroup.com/?l=3Dreiserfs&m=3D114709188305181&w=3D2
> That helped me get past the bootup phase (currently 8 hours uptime).
>
>  -Joe
>
> Alexander Gran writes:
> > Hi all,
> >
> > 2.6.17-rc3-mm1 doesn't get up running  here, it bugs around while init
> > runs: I cannot login afterwards, and syslog did not get the bug too. So
> > here are some poor screenshots from my Treo650 (digicam is broken,
> > sorry..;) EIP is in clear_inode.
> > Trace:
> > reiser4_delete_inode+0x6c/0xd0
> > d_delete+0xf0/0x10f
> > reiser4_delete_inode+0x0/0xd0
> > generic_delete_inode+0x6b/0xfb
> > input+0x5c/0x68
> > do_unlikat+0xd7/0x12c
> > sysenter_past_esp+0x54/0x75
> > __hidp_send_ctrl_message+0xb4/0xfa
> > details:
> > http://zodiac.dnsalias.org/images/1.jpg
> > http://zodiac.dnsalias.org/images/2.jpg
> > http://zodiac.dnsalias.org/images/3.jpg
> > http://zodiac.dnsalias.org/images/4.jpg
> > Kernel config:
> > http://zodiac.dnsalias.org/images/config
> > System is my T40p, as usual. running an up2date debian unstable.
> >
> > regards
> > Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart1648581.UYTTP183aE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEX96S/aHb+2190pERAkqYAKCEGVy+bFPMln4XzGkkRFAe9oY4SwCfcqP1
A/aUMVJiBJK9ap/DEehvL3I=
=ivb2
-----END PGP SIGNATURE-----

--nextPart1648581.UYTTP183aE--

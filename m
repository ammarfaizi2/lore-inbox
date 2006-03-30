Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWC3AUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWC3AUD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWC3AUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:20:02 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:50109 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750838AbWC3AUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:20:00 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Date: Thu, 30 Mar 2006 10:18:31 +1000
User-Agent: KMail/1.9.1
Cc: ashok.raj@intel.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       rjw@sisk.pl
References: <20060329220808.GA1716@elf.ucw.cz> <200603300953.32298.ncunningham@cyclades.com> <20060329161354.3ce3d71b.akpm@osdl.org>
In-Reply-To: <20060329161354.3ce3d71b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1148576.0bsUY1VZns";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603301018.36654.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1148576.0bsUY1VZns
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 30 March 2006 10:13, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > I think it's better to use selects.
> > I reckon that if the user selects SMP and then selects suspend support,
> > everything else required should be automatic.
>
> Yes.  `select' is end-user-friendly but kernel-developer-hostile.
> Sometimes it's infuriating trying to work out why a symbol keeps on getti=
ng
> turned on.
>
> <checks>
>
> hm, menuconfig's "/" command does show "Selected by:".  That helps.

This might give the Kconfig guys a headache, but maybe a middle road would =
be=20
to make selects turn on options rather than force them on. That is, make it=
=20
so that if SUSPEND depends on SWAP, and selects it, after enabling SUSPEND,=
=20
SWAP is also enabled, but you can still go to SWAP and turn it off, thereby=
=20
also disabling SUSPEND again?

Regards,

Nigel

--nextPart1148576.0bsUY1VZns
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKyPcN0y+n1M3mo0RAq0jAKDK8p+vqZpJoKSAHmy9+bifzk2ANACgknJD
xoekVUSPsVRlumBtiB8paL0=
=Pdg5
-----END PGP SIGNATURE-----

--nextPart1148576.0bsUY1VZns--

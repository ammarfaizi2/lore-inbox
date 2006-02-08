Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWBIACR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWBIACR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbWBIACR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 19:02:17 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:5297 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422676AbWBIACQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 19:02:16 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Complain if driver reenables interrupts during drivers_[suspend|resume] & re-disable
Date: Thu, 9 Feb 2006 09:58:57 +1000
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200602071906.55281.ncunningham@cyclades.com> <200602080040.41495.dtor_core@ameritech.net>
In-Reply-To: <200602080040.41495.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2320783.6PeMDbYEdH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602090959.02015.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2320783.6PeMDbYEdH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dmitry et al.

On Wednesday 08 February 2006 15:40, Dmitry Torokhov wrote:
> On Tuesday 07 February 2006 04:06, Nigel Cunningham wrote:
> > Hi all.
> >=20
> > This patch is designed to help with diagnosing and fixing the cause of
> > problems in suspending/resuming, due to drivers wrongly re-enabling
> > interrupts in their .suspend or .resume methods.=20
> >=20
> > I nearly forgot about it in sending patches in suspend2 that might help
> > where swsusp fails.
> >=20
>=20
> Only sysdevs are guaranteed to be suspebded/resumed with interrupts off,
> other devices are suspended with interrupts on (at least on first pass
> over device list).

Ok. I guess I missed that outcome of that discussion. Sorry for the=20
bogusness :(. Is the sysdev bit useful at all?

Regards,

Nigel

--nextPart2320783.6PeMDbYEdH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6oXFN0y+n1M3mo0RAuoFAJ94/oBsts/BU8fGeNtMTRJdhBERkwCePsdh
Vw7rlAXmMISOhLQBmn6k/Ck=
=WJdf
-----END PGP SIGNATURE-----

--nextPart2320783.6PeMDbYEdH--

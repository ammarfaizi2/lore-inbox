Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUBUNNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 08:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbUBUNNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 08:13:23 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:22796 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S261355AbUBUNNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 08:13:20 -0500
Date: Sat, 21 Feb 2004 08:13:18 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [RFC 2.6] sensor chips sysfs interface change (long)
Message-ID: <20040221131318.GA31688@babylon.d2dc.net>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
References: <20040218220845.361341c9.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20040218220845.361341c9.khali@linux-fr.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2004 at 10:08:45PM +0100, Jean Delvare wrote:
> Hi all,
>=20
> I plan to make rather important changes to the sysfs interface of I2C
> chip drivers in Linux 2.6. The topic has already been discussed on the
> lm_sensors mailing list, bug Greg KH suggested that I should explain my
> intentions here too, so here I am.

<snip>
> THE PLAN
>=20
> I propose a three-step plan.
>=20
> 1* Change the base scheme (e.g. temp_min1 -> temp1_min). This is the
> more important change (in the sense it affects all drivers and the
> libsensors library) and correspond to the second problem listed above.
>=20
> 2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only some
> drivers are impacted. Changes required to the library as well.
>=20
> 3* Add splitted alarm files. This doesn't break the interface (these are
> new files), but on the other hand needs that we think about it a bit
> more so that our choices are extendable and correct for all known
> drivers.
>=20
> Comments welcome (or even requested, according to the subject line).

I would like to further suggest the renaming of 'sensor<n>' to
'temp<n>_sensor' or 'temp<n>_type', in the interest of being consistent.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Perl =3D=3D Being
  -- Descartes (paraphrased).

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAN1luRFMAi+ZaeAERAsOKAJ9SULHLAnxKJ0ePH2/BLflpYSyqEQCg4oUy
ti98KuavrvZg+/xCz3mX9i0=
=pngB
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

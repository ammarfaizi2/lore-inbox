Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbTDYBYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDYBYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:24:30 -0400
Received: from dracula.eas.gatech.edu ([130.207.67.209]:61672 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S261848AbTDYBY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:24:29 -0400
Date: Thu, 24 Apr 2003 21:34:29 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.68] [BUG #18] Add Synaptics touchpad tweaking to psmouse driver
Message-ID: <20030425013429.GA20326@shaftnet.org>
References: <A46BBDB345A7D5118EC90002A5072C780C5923F7@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C5923F7@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2003 at 05:58:52PM -0700, Perez-Gonzalez, Inaky wrote:
> > Um, it doesn't reduce functionality.  There's a module parameter to
> > enable/disable the tap-to-click.  :)
>=20
> Can that be made a /sysfs tunable?

That's the plan.  :)

I now have a fully native synaptics driver that has a bazillion tuneable=20
parameters, but they're not exported into /sysfs yet.

Once I get the rest of the kinks worked out (and sane defaults for the=20
tuneables) I'll add in /sysfs support, and post another patch.

Let me know if you want to live dangerously sooner...

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
                                                           ICQ #1318444
Quidquid latine dictum sit, altum viditur                 Melbourne, FL

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+qJClPuLgii2759ARAjrLAKCcE+606dopZj9t4QMUWgdgjrMGuQCfdog4
fD29cq8A2Ryt2o9oFxF88kQ=
=9PAP
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

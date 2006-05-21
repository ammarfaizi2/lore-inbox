Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWEUWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWEUWkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWEUWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:40:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:54227 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751497AbWEUWkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:40:22 -0400
X-Authenticated: #2308221
Date: Mon, 22 May 2006 00:40:12 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060521224012.GB30855@hermes.uziel.local>
References: <200605212131.47860.pgquiles@elpauer.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <200605212131.47860.pgquiles@elpauer.org>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

On Sun, May 21, 2006 at 09:31:30PM +0200, Pau Garcia i Quiles wrote:

> [interesting idea with complex implementational problems]

I think it would be cheaper ("costs" for your solutin in terms of
required I/O power and hard disk space) to use two or more lead
batteries which are charged and discharged in a round-robin fashion,
controlled by some smart home-brew circuitry, and connect the beast to
some control/monitoring software via RS-232 ; )

The logic should at least completely drain the battery before
recharging, and maybe even do a quick-and-hot charge-discharge-charge
cycle every now and then to reduce chemical byproducts at the cathode -
or was it the anode? Well, one of them is dissolved over time, and the
other one collects some sulfate or sulfide or something. If you want it
really complicated and robust, you might want to monitor the electric
parameters of the batteries at all times, to estimate the minimum
remaining time once the power is cut. You'd then have to shut down, or
better hibernate, the system cleanly within that time frame to be safe
=66rom data loss.

I'd love to do something like that sort of in-between the PSU for a
single machine, for this would avoid the need to go from AC to DC and
back, but lacking the electrotechnical skills I'm not self-confident
enough to try and waste my PSU. Anyway, this has gone way off-topic by
now.

Kind regards,
Chris

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHDsS12m8MprmeOlAQK96Q//UYfr/UnLrwsGhurTLhkAh/Hn6gKOU0RO
NOKeOGjBJQELq84wqeCjhUMC8Tg6JsysffLTsjPUQdCgISAP9WSRkw43N8oXXEcN
qpQXBCkWRbT8f6CXbafO8DT277sEoOaRsFK2JvVaVXfUEwWmmUPVpUJaFBm/O7OR
rr49zjcjTDe8H2bKTRNNEFCxaCyhvk3/G/JYDApyls55Gkw9lnVIuwGSkSwMehc0
Fek3lzq/FsZOhvB0s5dPB2m314acc1WxVIj0kkZYc9LzNPSdVF0mi04TVNyPZs5N
uXdJKLhgdIBSVNZgrJ/Ha44EZ6EcosJq33jMBOvGMjvKHjY2w+XFGN+5/6BHswfy
j5N7sE8KHXwLQWjreD+3lAIrXffB4ZttkF4jdeYM/A19x2o4VPC2eKtGpH5n8UJ+
xJ9pRxMlZiIiQzpBRhw5mGkM0hbnHltNM8e5/fssRJQB3Ne2M0OzG11F2/oz+D5i
EMZXmZOvRI+1qdOnvRZM/tQkTZX16BhZMSt1KJ4+SFF1GPlN96cRK5akl27Y5d7c
TTrGPJewOgRcVKN2QwKqt6WZwwolWcAhtMV8hzpSwNcZLOXoXktidC7Bdba7hT4N
/H6zhm7cngo8SF6GSoERA44qWhZ3IZaQzeeJJacc0KCu/SAd88W+218Tx/XuGy/P
HaJ+Qq6IElg=
=/m2O
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--


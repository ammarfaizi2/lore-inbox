Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWEVTej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWEVTej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWEVTej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:34:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:35715 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751151AbWEVTei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:34:38 -0400
X-Authenticated: #2308221
Date: Mon, 22 May 2006 21:34:12 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Christian Trefzer <ctrefzer@gmx.de>, Jan Knutar <jk-lkml@sci.fi>,
       Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060522193412.GB5995@hermes.uziel.local>
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <Pine.LNX.4.61.0605220908580.26879@chaos.analogic.com> <20060522152531.GB4538@hermes.uziel.local> <Pine.LNX.4.61.0605221139040.27175@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605221139040.27175@chaos.analogic.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2006 at 11:54:56AM -0400, linux-os (Dick Johnson) wrote:
=20
> Telco used watt-meters and clocks to directly monitor the batteries.
> In the event that the batteries had been floating for a month (not used
> and trickle-charging), the timer would send them an equalizing charge
> of about 10 amperes for 10 minutes. That would blast away any surface
> corruption and bring the individual cells up to an equal terminal
> voltage.

Nice : )

> Modern chargers just don't bother unless the batteries are used for
> medical equipment. In our portable CAT Scanners, we monitor current,
> voltage, and time using a uP. This guarantees that once you start
> a scan, the scan will complete (as required by regulatory agencies).
>=20
> We also charge at a constant current until getting to the correct
> terminal voltage. In other words, the charger is current-limited
> until the voltage is correct, then it becomes voltage regulated.

Constant-current / constant-voltage - just like Li-Ion batteries are
supposed to be charged. Talk about complexity ; )

IMHO battery "care" even in modern laptops sucks, so I'd rather have two
battery packs, one in use and the other one being charged. External
chargers don't seem to exist, AFAICS, so I'd very much like to build
one. Welcome to utopia...

> The regulated voltage depends upon temperature and you can get
> the numbers off from battery vendor's specifications. We don't
> set an "equalizing charge" as telco did. We found with our specific
> batteries it wasn't necessary.

Yup, the chemical processes inside the cells depend on temperature - do
your chargers monitor that as well?


Thanks a bunch,

Chris

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHISM12m8MprmeOlAQLNFxAAwCtle54ZwpOIkRSuY36dIFzZ591dqISi
NnOc6npJcIIROv89dGR1HT2NDpSAQrPNWFGguwO5+6SgXRUe3shTaQj/t8UCm45K
fHlghVa5Fbn6YFVlEHEaQ2Ll6zQhbZqa2owT+JHmmDJERfZZ7NXvc7T2UjzIAI4u
VrK31QuRXN5m1/6Cz9EVb34nOgZHYPjpfFFo/Oj8JhvXy6ZsvPQWlJtvhsh7zSPl
f+JC/ukIEtGIayROjLEvKphoCp86fHFmt/R1pz1Xybe5VZO0V1oEdpV+XyoupKHG
PC93UFRff2x66s/fUvQEdxSodM1S+0hkELyAziug7JvXCXB4aB2c9uHseoU5lwKs
Z6ka4c/7ywcD8ZTyz0qII7SP2qzcKG0EZq7XBxPF4Q2K0JmDYklyyyxKFntWYopo
P4KIdwvylKsUVo3mtXedjhsPm2QVHbqBVlyPlSWHjU6PEGr18WvXFuvtn/Hq2aXz
/7RpcuLZe/FgBNSddxcZkW619/JohBNHTpEP310QNNq5SGZWJRn7dmsFYXXdtgaP
vTKQtKDmJ7OzgnIaCLNBqvVXVTn2rgt1bH2hdxCivoWJn+A3FGYTEaIclbMXlf75
BNZL+5TsLZ4ygbciX6Ca3bCVcALM5dh0lmyH1b70OYxDrYGkaciVxOg7xjLYesFh
sz0SLcjFc8E=
=uy/y
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--


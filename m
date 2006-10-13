Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWJMSKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWJMSKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWJMSKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:10:50 -0400
Received: from nsm.pl ([195.34.211.229]:58570 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751774AbWJMSKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:10:49 -0400
Date: Fri, 13 Oct 2006 20:10:30 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Strange entries in /proc/acpi/thermal_zone for Thinkpad X60
Message-ID: <20061013181030.GA11662@irc.pl>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Brown, Len" <len.brown@intel.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
References: <fa.P/oAhFV0AVrh8PKSKzP+xVGih2s@ifi.uio.no> <452F0EB7.2060508@shaw.ca> <452F15DC.8080701@goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <452F15DC.8080701@goop.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2006 at 09:28:12PM -0700, Jeremy Fitzhardinge wrote:
> Robert Hancock wrote:
> >I would expect they wouldn't, otherwise there would be no reason for=20
> >the BIOS people to set up two thermal zones..
>=20
> Ah, OK.  I misunderstood what thermal zones are.
>=20
> >How do you know they are one for each core? ACPI thermal zones can be=20
> >anywhere in the machine that needs OS-controlled cooling. Could be the=
=20
> >CPU heatsink, voltage regulator, or someplace else.
>=20
> Right, bad assumption on my part.  Is there any way to find out what=20
> they might correspond to?  /proc/acpi/ibm/thermal has a bunch of=20
> temperature-like numbers in them; I guess there should be some=20
> correlation between those and the thermal zones.

  There are many temperature sensors in Thinkpads. There's even map of
them somewhere on http://www.thinkwiki.org.

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFL9aW10UJr+75NrkRAvjMAJ91ShWmLIAlVOVn4ackaNtugm+eBgCfQw16
jkw3KCCpvgcpAHzAPwtAHBQ=
=A6je
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

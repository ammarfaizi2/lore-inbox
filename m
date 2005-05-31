Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVEaVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEaVVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVEaVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:21:55 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:21435 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261519AbVEaVVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:21:51 -0400
Date: Tue, 31 May 2005 23:21:41 +0200
From: Martin Waitz <tali@admingilde.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DocBook build failures, and graphical figures
Message-ID: <20050531212141.GC14161@admingilde.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <429CAD7B.5070301@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KqIDP7BYbqnwKRO+"
Content-Disposition: inline
In-Reply-To: <429CAD7B.5070301@pobox.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KqIDP7BYbqnwKRO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, May 31, 2005 at 02:31:23PM -0400, Jeff Garzik wrote:
> In each failing case, I can use "db2ps" or "db2pdf" to successfully=20
> convert the XML file, whereas xmlto fails.

yes, passivetex (which is used by xmlto to process XML-FO) is not as
stable as I thought.
It breaks at strange times but I did not yet had the energy to really
look into it.
So we probably have to support db2pdf/ps again.

> * Can you make it easy to change the paper size to something custom,=20
> like 6x9in ?

you should be able to put the following lines into stylesheet.xsl:
<param name=3D"paper.width">6in</param>
<param name=3D"paper.height">11in</param>

would it be easy enough if I provided some commented out entries?
(well the above only works for xmlto, I don't know how to set
the paper size for db2*)

> * Is there an example somewhere describing how to insert graphics=20
> (figures and charts) ?

you can insert graphics with
<mediaobject><imageobject>
<imagedata fileref=3D"blah.png" format=3D"PNG"/>
</imageobject></mediaobject>
(See http://www.faqs.org/docs/docbook/html/mediaobject.html)

The above generates an <img src=3D"blah.png"> in HTML mode.
Is that what you want?

--=20
Martin Waitz

--KqIDP7BYbqnwKRO+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCnNVlj/Eaxd/oD7IRAr/+AJ0bF3qPO2OhuJ0s95sPSgqYrW7WOwCfaEMC
ei0vPpyh4hZV8VwSd2kfD1Y=
=CDhC
-----END PGP SIGNATURE-----

--KqIDP7BYbqnwKRO+--

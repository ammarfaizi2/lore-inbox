Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUIUREP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUIUREP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUIUREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:04:15 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:27613 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267852AbUIUREH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:04:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Subject: Re: [Patch][RFC] conflicting device major numbers in devices.txt
Date: Tue, 21 Sep 2004 19:03:25 +0200
User-Agent: KMail/1.6.2
Cc: David Woodhouse <dwmw2@infradead.org>, "Cagle, John" <john.cagle@hp.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Torben Mathiasen <device@lanana.org>, linux-mtd@lists.infradead.org,
       Horst Hummel <Horst.Hummel@de.ibm.com>, linux-390@vm.marist.edu,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <C50AB9511EE59B49B2A503CB7AE1ABD108F82153@cceexc19.americas.cpqcorp.net> <200409211703.47188.arnd@arndb.de> <20040921164938.GQ4055@linux>
In-Reply-To: <20040921164938.GQ4055@linux>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_e7FUBjOqBjZ8+pU";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409211903.26130.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_e7FUBjOqBjZ8+pU
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dienstag, 21. September 2004 18:49, Torben Mathiasen wrote:
> On Tue, Sep 21 2004, Arnd Bergmann wrote:
> > On Dienstag, 21. September 2004 11:23, Torben Mathiasen wrote:
> > > s/390 dasd moved to major 94.
> > > s/390 VM/ESA moved to major 95.
> > > INFTL moved to major 96.
> >=20
> > Actually, major 95 has never been used for VM minidisks or any other
> > s390 block device in any 2.4 or 2.6 based distribution, because that
> > driver was integrated into the dasd driver (it just uses a different
> > access method on the same devices). You might want to document that
> > this number is currently unused, even if it doesn't get assigned to
> > any other driver.
>=20
> So, what you're saying is that Major 95 is not used at all in real life? =
Then
> I'll remove it from from the list completely during the my next push. Let=
 me
> know if there's a point in keeping it assigned even if its obsolete.

I don't see any reason to keep it for s/390, but I added some potentially
interested parties to the CC: list. If anyone is thinking of reusing device
major number 95 for s390 minidisks, speak up now, otherwise it will finally
be gone.

	Arnd <><

--Boundary-02=_e7FUBjOqBjZ8+pU
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBUF7e5t5GS2LDRf4RAkHbAJ9m3WNmkKqbNYRCsJCVWKZxSHnvwwCfQ1sC
00xhplW9x8S2BRYunrTHJfs=
=MHiV
-----END PGP SIGNATURE-----

--Boundary-02=_e7FUBjOqBjZ8+pU--

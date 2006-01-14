Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWANNWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWANNWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWANNWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:22:20 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:17028 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751404AbWANNWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:22:19 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org, chaosite@gmail.com
Subject: Re: [patch 00/62] sem2mutex: -V1
Date: Sat, 14 Jan 2006 14:22:10 +0100
User-Agent: KMail/1.7.2
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
References: <20060113124402.GA7351@elte.hu> <20060113195658.GA3780@elte.hu> <43C815E3.10005@gmail.com>
In-Reply-To: <43C815E3.10005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2287981.FuHF0FjZ6I";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601141422.16760.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2287981.FuHF0FjZ6I
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 January 2006 22:04, Matan Peled wrote:
> Ingo Molnar wrote:
> > Ingo Oeser wrote:
> >> Could we get for each of these and a mutex:
> >>
> >>  - description=20
> >>  - common use case
> >>  - small argument why this and nothing else should be used there
> >=20
> > like ... Documentation/mutex-design.txt?
>=20
> I think what he wanted was an explanation for the change of each and ever=
y=20
> sem... Which is kind of hard with automated tools.

No this is too much! I wouldn't expect this.

Just example conversions for each 3 conversion types with full discussion=20
(or discussion at all) like we do for all other patches would be enough.

semaphore -> mutex is explained a bit in Documentation/mutex-design.txt

Still missing:
 - semaphore -> completion
 - semaphore -> struct work


Regards

Ingo Oeser


--nextPart2287981.FuHF0FjZ6I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyPsIU56oYWuOrkARAt55AKDkW3m7c+J/vUM/qeh49/oGRQhuhgCbBx26
HEPuBsbwHUxDgfrFt8FfSM0=
=/AaD
-----END PGP SIGNATURE-----

--nextPart2287981.FuHF0FjZ6I--

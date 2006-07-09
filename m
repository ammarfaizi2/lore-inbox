Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWGIVqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWGIVqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWGIVqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:46:25 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:22474 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161171AbWGIVqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:46:25 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Mon, 10 Jul 2006 07:46:20 +1000
User-Agent: KMail/1.9.1
Cc: Bojan Smojver <bojan@rexursive.com>, Pavel Machek <pavel@ucw.cz>,
       Arjan van de Ven <arjan@infradead.org>, Sunil Kumar <devsku@gmail.com>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607100706.45789.ncunningham@linuxmail.org> <200607092336.44208.rjw@sisk.pl>
In-Reply-To: <200607092336.44208.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1556384.FS70y7KZMn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607100746.25043.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1556384.FS70y7KZMn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 10 July 2006 07:36, Rafael J. Wysocki wrote:
> On Sunday 09 July 2006 23:06, Nigel Cunningham wrote:
> ]-- snip --[
>
> > > Now there's the separate problem that we have to share _some_ code.
> > > To an absolute minimum, we have to share the freezer code and the
> > > code that handles devices, because it's also shared by suspend-to-RAM.
> > > The code that handles devices is already shared, but we also _have_
> > > _to_ share the freezer code.  Therefore, as long as suspend2 adds some
> > > code to the freezer, it's not even close to be considerable for
> > > merging.
> >
> > If Suspend2 added code in a way that broke swsusp, I would agree. But it
> > doesn't.
>
> This is not a matter of any breakage or lack thereof.  The problem is that
> the freezer is _not_ _an_ _swsusp-only_ _code_.  It is used by someone el=
se
> too, and having two different freezers in the tree would be _insane_,
> because too many things depend on that.  This would be like having two
> different memory management systems, but at a smaller scale.

Please don't start doing what Pavel does, imputing to me motives and ideas=
=20
that are clearly false. You know that I don't want to have two freezer=20
implementations - I've never suggested the idea or even thought of it until=
=20
you suggested it. My desire all along has been to improve what's already=20
there, and I still want to do that.

I'm sorry that I'm not submitting and resubmitting things as fast as you'd=
=20
like. Please try to remember that I'm not a full time programmer. I'm worki=
ng=20
for Redhat one day a week and the congregation I serve four days a week.=20
Anything I do beyond the one day is purely my time, and I have plenty of=20
other things to do too. It's not, therefore, that I want to drag my heels.=
=20
Rather, I simply don't have the time to get things done as quickly as you a=
nd=20
Pavel seem to be able to.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1556384.FS70y7KZMn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsXkxN0y+n1M3mo0RAqWdAJ9vUTjaViihnlwoYurJyWLSh6Nv8ACfdgZw
FKVSRrIz/r/PALuqYTJoZgA=
=e/Ko
-----END PGP SIGNATURE-----

--nextPart1556384.FS70y7KZMn--

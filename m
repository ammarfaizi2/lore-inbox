Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWGIACt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWGIACt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWGIACt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:02:49 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17293 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932358AbWGIACt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:02:49 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sun, 9 Jul 2006 10:02:41 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607090828.36834.ncunningham@linuxmail.org> <20060708235434.GG2546@elf.ucw.cz>
In-Reply-To: <20060708235434.GG2546@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1499802.7uYzLG8ZNS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607091002.48153.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1499802.7uYzLG8ZNS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 09:54, Pavel Machek wrote:
> Hi!
>
> > > > > It's only too slow on swsusp. With Suspend2, I regularly suspend
> > > > > 1GB images on both my desktop and laptop machines. I agree that it
> > > > > might be slower on a
> > >
> > > uswsusp is as fast as suspend2. It does same LZF compression.
> >
> > I agree for uncompressed images - I tried timing the writing of the ima=
ge
> > yesterday. I'm not sure about LZF though, because I couldn't get it to
> > resume. I'd be interested to see it really be as fast as suspend2 with
> > compression.
>
> Is there any way to help you? I assume normal swsusp resumes okay so
> it is not driver problem?

That's right. I'll see if I can figure it out tomorrow, Lord willing. I=20
have /dev/snapshot in my initrd but it gives that prompt asking for the=20
device name. By the way, will it sit there foreever, or does that have a=20
timeout?

> > > Do you think you could get some repeatable benchmark for Rafael? He
> > > worked quite hard on feature only to find out it makes little
> > > difference...
> >
> > Sure, but it will mean more if all of the tests are run on the same
> > system, so I'll have another go at getting uswsusp to resume, when I get
> > the chance.
>
> Thanks.

No problem.

Nigel

=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1499802.7uYzLG8ZNS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsEeoN0y+n1M3mo0RAq98AJ4zlL6pHardtLSnFoZclOKy7IasygCgh0jA
ihtpeTJGKQDgxdWRZ+G9SaA=
=kqVv
-----END PGP SIGNATURE-----

--nextPart1499802.7uYzLG8ZNS--

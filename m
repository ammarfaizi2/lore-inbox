Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWGHN0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWGHN0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWGHN0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:26:23 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:55020 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S964826AbWGHN0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:26:22 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sat, 8 Jul 2006 23:26:13 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607082131.47832.ncunningham@linuxmail.org> <20060708125200.GA1762@elf.ucw.cz>
In-Reply-To: <20060708125200.GA1762@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1626254.vUINjjB3HL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607082326.18237.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1626254.vUINjjB3HL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

'ello.

On Saturday 08 July 2006 22:52, Pavel Machek wrote:
> > > > Frankly, I'd rather be working on improving drivers and helping
> > > > implement the run-time power management than working on getting
> > > > Suspend2 merged.
> > Developmentwise, I think it's finished - unless I want to go off in a n=
ew
>
> I'd say that suspend2 already done its job -- forced me to do
> uswsusp. I do not think it is mergeable without major refactoring.

I'm sorry, Pavel, but it if uswsusp is going to be an acceptable replacemen=
t=20
for Suspend2, it has to actually have the features suspend2 has implemented=
,=20
not just have the promise of them appearing at some stage. Rafael is doing=
=20
admirable work in that direction, but he's not there yet.

On the day when I feel like I can switch from suspend2 to swsusp with no lo=
ss,=20
and am convinced that my users can do the same, I'll happily switch. I've=20
said all along, I'm just a user who wanted to suspend. I'm still a user who=
=20
wants to suspend. I'm not committed come hell or high water to getting=20
Suspend2 merged. But I am committed to having a good, usable implementation=
=20
that just works. If you can get there with uswsusp, feel free. In the=20
meantime, though, I have an implementation that I and many other people are=
=20
happy with and I'm not convinced that you will be able to do all you're=20
promising, so I'll have a go at getting Suspend2 merged. If Andrew and Linu=
s=20
don't want it, well it's no biggy to keep maintaining it out of tree. I'll =
be=20
saddened for the people who miss out in the meantime, but I'll still sleep =
at=20
night.

> Helping with runtime power management would be more welcome than
> resubmitting same code over and over. Good news is that you can now do
> what you prefer :-).

> > > As far as the support for ordinary files, swap files, etc. is
> > > concerned, there's nothing to worry about.  It's comming.
> >
> > Great. It will be good to see that. Do you have some way around bmapping
> > the files?
>
> You mean "some way to go without bmapping" or "did you get bmapping to
> work" ?

Some way to go without bmapping. I'm assuming you're going to have to add s=
ome=20
kernel code to at least do the bmapping. By the way, watch out for block=20
sizes. Especially with XFS. It's the best test of whether your code is righ=
t=20
because the blocksize XFS uses might not be the same as the underlying bloc=
k=20
device's blocksize.

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1626254.vUINjjB3HL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEr7J6N0y+n1M3mo0RApEUAJ9q3/zN7ovrCTPw8NA3H4k/kJskBQCfd7nL
ymLBTt9JujsThIB1GUHCd5U=
=cz8Z
-----END PGP SIGNATURE-----

--nextPart1626254.vUINjjB3HL--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUAAVss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUAAVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:45:28 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:3207 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265051AbUAAVlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:41:00 -0500
Subject: Re: best AMD motherboard for Linux
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Derek Foreman <manmower@signalmarketing.com>,
       Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FF45307.7070508@inet6.fr>
References: <3FEF0AFD.4040109@yahoo.com>
	 <20031228172008.GA9089@c0re.hysteria.sk> <3FEF0AFD.4040109@yahoo.com>
	 <20031228174828.GF3386@DervishD>
	 <20031229165620.GF30794@louise.pinerecords.com>
	 <Pine.LNX.4.58.0312301144340.467@uberdeity>
	 <20031230194203.GA8062@louise.pinerecords.com>
	 <Pine.LNX.4.58.0312301354130.765@uberdeity>
	 <20031231093929.GC8062@louise.pinerecords.com>
	 <Pine.LNX.4.58.0312310914170.473@uberdeity>  <3FF45307.7070508@inet6.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rBH3PsB6EMal5xUM+s1v"
Message-Id: <1072993410.14629.33.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 23:43:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rBH3PsB6EMal5xUM+s1v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-01 at 19:04, Lionel Bouton wrote:
> Derek Foreman wrote the following on 01/01/2004 07:15 AM :
>=20
> >On Wed, 31 Dec 2003, Tomas Szepe wrote:
> >
> > =20
> >
> >>On Dec-30 2003, Tue, 18:46 -0600
> >>Derek Foreman <manmower@signalmarketing.com> wrote:
> >>
> >>   =20
> >>
> >>>His primary requirement was that it (the motherboard) work well with
> >>>linux.  He stated that he was capable of installing drivers if he had =
to,
> >>>but it would be even better if it wasn't required.
> >>>
> >>>Open source drivers, or whether nvidia fits your idea of a "linux
> >>>supporting company" were not on the stated list of requirements.
> >>>     =20
> >>>
> >>Indirectly they were, if you admit that opensource drivers are "better"
> >>for Linux users.  The person's goal was, let me quote, "to make sure
> >>I get the hardware that works best with Linux."  I suggested they avoid
> >>nVidia, because _my opinion_ is that binary-only drivers do not "work b=
est."
> >>   =20
> >>
> >
> >I think we're just going to have to disagree on what "work best" means. =
 I
> >choose to interpret it as a measure of driver functionality and
> >performance.
> >
> >Your definition of "work best" is based on a political agenda, and not o=
n
> >technical merit.
> >
> > =20
> >
>=20
> Linux isn't a closed-source system where binary APIs are frozen, so=20
> working best with a set of specific kernels (and I don't even say kernel=20
> versions, I *mean* kernels, just search for threads on nvidia with=20
> kernels built with some perfectly legit gcc flags) doesn't mean it is=20
> working best with Linux.
> What if Nvidia goes bankrupt in the future like 3DFX did, what do you do=20
> with your card ? throw it away ?
>=20

The point which you and some of the others that maybe did not use
2.5.* on systems with nvidia cards, is that only the very specific
hardware calls is closed source (nvidia.o), the rest (kernel interface,
agp, vm, etc) is done with source that you need to compile.  Thus we
already (thanks to great work from a few guys at minion.de) used
a 2.4 driver with 2.5.  Also, a lot of 2.5/6 bugs, and guess what,
even 2.4 vm bugs was fixed, because we had most the source.

I even used it later with 2.5 and NPTL (when the first versions of
the GLX part that supported TLS came out), and to be honest, I have
had very little problems.  If I could not fix something myself, it
was usually very quickly fixed minion.de side.  Sure, maybe I am
just lucky (or maybe its because I do not use AMD, or VIA chipset
mobo - bug that is another story :D), but the fact is that for a
_lot_ of us out there, we had nVidia cards going 3D, while the
DRM/DRI was in a state of flux.  To be honest, _I_ have not had
much success with DRI in general.  If I could get it to work (this
means it actually initializes, and glxgears/glxinfo seems to use
direct rendering) with the SIS box at work, or with an ATI card
I borrowed, it would create artifacts, lockup, or such.  You do
not hear me going off about DRI on the list?

On the other hand, it seems you had issues :/  Maybe check that
you did not use rivafb - I never had issues like yours *shrug*.

I guess the point Derek wanted to make, and where I want to fill
in, is that you cannot say for a fact that something will work,
or not for all.  For some, the nvidia drivers works great, and
if you are into games, it will prob give better performance.  For
some it wont.  For some DRI works, for others, not.  And the 'its
a binary driver, so you cannot debug/fix it' does not hold the same
as it used to these days with the new types of ati/nvidia drivers.

If you are a 'open source fanatic', please keep your wits with you,
and do not try to get everything into a 'closed source is evil'
argument.  I am sure most of us are to some extend fanatic about
open source, but there is a time and a place.  The fact is, unless
something drastically happens to the commercial sector, we will always
have companies that do not want to fully release all specs, as they do
not want to loose their 'edge' - but you do not have to support them,
right?

Hey, its Linux - we have the choice, right?  Unfortunately it seems
that some still want to take that choice from others :/

<ramble/>


--=20
Martin Schlemmer

--=-rBH3PsB6EMal5xUM+s1v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/9JSCqburzKaJYLYRAvy2AJ9PA11D7Ku5dQZYIytl22/kV0rAzwCfdkp8
1jpS9lz06gB07yEvfANkbBo=
=OS6+
-----END PGP SIGNATURE-----

--=-rBH3PsB6EMal5xUM+s1v--


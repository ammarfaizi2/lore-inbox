Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVAZQGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVAZQGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVAZQGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:06:55 -0500
Received: from dea.vocord.ru ([217.67.177.50]:29355 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262339AbVAZQFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:05:37 -0500
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <waZNwjBp.1106750054.2006670.khali@localhost>
References: <waZNwjBp.1106750054.2006670.khali@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RBN1bAIO/fIaJR40kFCy"
Organization: MIPT
Date: Wed, 26 Jan 2005 19:10:19 +0300
Message-Id: <1106755819.5257.207.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 16:04:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RBN1bAIO/fIaJR40kFCy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 15:34 +0100, Jean Delvare wrote:
> Hi Evgeniy,
>=20
> > I presented the code.
> > Several times in special mail list.
>=20
> That's true. Except that the second time (at least) you didn't find
> anyone to review it. Also note that your patches are about superio, gpio
> and now access bus. The list is dedicated to hardware monitoring. This
> is no exact match, although it happens that some superio chips include
> hardware monitoring logical devices. So I reviewed the part I think I
> could help with, and skipped the rest (and I did tell the you, and the
> list, that I had).

It is the most closest to the superio subsystem mail list,
and all comments presented there about superio code were always right
and=20
indeed usefull.
I believe I addressed them all(except function prefixes :) )

> > Only problem that it was not sent to lkml, where there are=20
> > too many noise and flood. That is why while digging through it several=20
> > years ago I decided to drop this mail list.
>=20
> I agree that there is a heavy traffic on LKML - I am not subscribed
> myself just because of that. However, when one introduces a completely
> new subsystem, it definitely needs review by folks that have way more
> knowledge about the kernel internals than I do - expecially about the
> (bus) driver model.

A bit offtopic: the reason why we have such long discussion about
superio=20
is not that it is new, and you can see it if you dig the archive from
the=20
beginning.

> > I do not understand you, what are you trying to say? Waht is wrong?
> > I wrote the code.
> > I presented it.
> > I presented it again.
> > I presented it yeat another again.
> >
> > First time people answered, then - not.
>=20
> OK, blame me for having a day job, a girlfriend and a family. Blame me
> for not having the necessary time and knowledge to review your code.

:) You misunderstand me, sorry.
I absolutely did not want to blame anyone and=20
even did not have it in my thoughts :)

> And then think about it again. Maybe you did not present it to the right
> person(s). Maybe you did not present it in the correct form. Maybe you
> didn't properly explain what problem you were trying to solve - and
> failed to catch people's attention because of that. And maybe you
> should not have ignored some of my comments - and others'. I would
> invite you to read your own recent posts to the LKML again. Most
> objections you have received about your code - some of which were so
> blantantly valid (several drivers with the same name is fine, no
> kidding) - you first denied that there were any problem, then grumbled,
> then accepted to change but just not to make any trouble - not because
> you were wrong. You are not going anywhere here with this attitude.

<not personal to you reasonings...>
Most objections are so small, that is can not be called problems.
I will fix it soon.

And I still do not see any problems there, I just do not want to spend
my time in such meaningless dispute about module names.
I'm not religious fanatic which will with foam at the mouth try to
make it's word latest.
I prefer to do interesting things and it is much easier to change the
module=20
name than try to convince army of opponents :)

Superio design as actually another isssue, although I still do not
understand
why break well written working code just to what?
As I said, talk is cheap, if only discuss design notes, nothing can be
created.
</not personal to you reasonings...>

> Sure, we, kernel developers as a whole, lack time to properly review all
> the code that is sent to us. Even me, and I probably receive one
> hundredth of what Greg, Andrew or Linus receive. And now what? That's
> the way it is and we (and you) have to live with it. If you want the
> situation to improve, you can volunteer to review some code. Andrew's
> broken-out directories and LKML are full of patches that need review. Or
> pick one subsystem and track the patches applied to it. Really, do not
> hesitate to help. You certainly will learn much about kernel code review
> by doing so, and your own submissions are likely to be significantly
> better thanks to that. My story exactly.

And do I blame anyone?
Did I said that all you are fscking monsters that do not like my baby?

No, I presented the code and appreciate anyone's comments.
Thank you.

> > I ask for inclusion. It is included, and ohh now people recall,=20
> > that they wanted to complain.
>=20
> What other choice do they have at this point? Ignore or complain. I
> definitely prefer them to complain if they have a reason to - and the
> same would apply if it was my code and not yours.

I do not say it to your personally, but in general:
Let's discuss the code, let's discuss the design, but do not try to
say,=20
that code is bad just because one never see it before and it was just=20
appeared here, and one do not understand something...

Most of the thread is not discussion...

> Note that I don't blame Greg for pushing the code into Andrew's tree.
> This is what this tree is for, and now your patches got some exposure
> and you have objections to work on, to say the least. I also admit that
> some people here are being a little harsh, but I believe that each one
> of us is doing his/her best to improve the kernel. It just happens that
> our best isn't always as good as one would want.
>=20
> > Ok, I want to listen what technical problems do you see?
>=20
> As I explained before, I would like to see your superio subsystem
> integrate properly with existing drivers that need it before you attempt
> to add more functions on top of it. And I want a full documentation of
> your superio subsystem to be part of the patchset. It seems that most
> people here didn't get what you were doing and why you were doing it
> (at least I wasn't alone ;)), so obviously a complete documentation
> would be more than welcome - needed would in fact be the appropriate
> term.

Sure, I definitely will devote much time to document all pieces.

>=20
> > Jean, it looks like you forget how superio is designed.
> > Your pc87360 driver is all in one big piese of code, superio
> > is splitted into absolutely separated modules - _one_ for superio chip,
> > and _several_ for logical devices.
> >
> > I need to split your driver into at least 5 parts - pc8736x=20
> > initialisation(superio has it), i2c part(should be removed from superio
> > code), fan logical device(separate part), voltage monitor logical devic=
e
> > (separate part) and temperature monitor logical device (separate part).
>=20
> The whole thing is a single driver because it achieves one goal. The fact
> that National Semiconductor decided to use three different logical
> devices for temperatures, voltages and fans is an implementation detail.
> This alone doesn't justify a split of the source code. The "superio
> chip" part is what you have been working on and I agree it was needed.
> And I agree that the superio access has to be moved from my pc87360
> driver (and other similar drivers) to your superio driver.
>=20
> You do not *have* to separate all the parts. One single driver can
> request several logical devices, and this is precisely what I want us to
> do here. I agree that it could make sense to separate the logical
> devices on a per device (and driver) basis, if it allows us to reuse the
> code more easily. It is however not a requirement, that I can see.

I mean above that we need to separate them logically from superio
access=20
and i2c part.
But it is really better to have each logical device driver be a separate
module,=20
it is just easier to search and handle.

> > They are just separate modules, it is design feature to use _the_ _same=
_,
> > for example, voltage monitor module with _any_ number of existent super=
io
> > chips.
>=20
> It isn't the first time you say that, and I have to say I don't much
> get where you want to go. The hardware monitoring logical devices are
> completely different between PC8736x, IT87xxF, W836x7(T)HF and 47M1xx
> superio devices, just like the various other hardware monitoring chips
> are different. There is no code to be shared here, so nothing is
> duplicated.
>=20
> Maybe it is different with gpio or access bus? Is there some standard
> register organization among the various chip makers? I don't know
> these, so I cannot tell.

As I saw from different documentation - logical devices itself are the
same.

And it is the same for superio standard.

For example sc1100 and pc87366 superio chips have the same logical
inside,=20
although different logical device set.

> > And that will end up having tons of duplicated code in each driver:
> > temp monitor in A, temp monitor in B and so on...
> > volt monitor in A, volt monitor in B and so on...
>=20
> There is no logical device-based duplicated code in the superio hardware
> monitoring drivers at the moment, unless you see things I do not (if you
> do please let me know). The only thing that is duplicated accross the
> drivers is the superio accesses, agreed, and I am glad that your unified
> superio driver will put an end to this.

Not only access.
Logic inside superio chip is submitted to superio standard.
I designed(at least tried to) superio subsistem
that it can handle all differencies using per device callbacks.

> > Jean, we already discussed it a bit in lm_sensors mail list AFAR...
>=20
> Yes, 5 months ago, and we did not exactly agree. And we obviously still
> do not agree.
>=20
> Don't get me wrong, I am not saying that I don't want your code in the
> kernel. I am actually interested in it (the base superio part, in fact).
> All I am asking for is that you put some efforts in presenting your code
> correctly, splitting it the way it has to be, and getting it into the
> kernel step by step. You are not going to get any support from me by
> pretending that the superio hardware monitoring drivers need a full
> rewrite to accomodate with your unified superio driver - because I know
> it cannot be true. If you can provide a first patchset with core superio
> driver, documentation of it, and *minimum* updates of the pc87360 driver
> to make use of it, you can be sure I will review it with great care.

I definitely will do it.
Just get me time :)

Thank you.

> Thanks,
> --
> Jean Delvare
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-RBN1bAIO/fIaJR40kFCy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB98DrIKTPhE+8wY0RAiCYAJ47qyNBPxLvU6su1pSpEjeCEJ1okwCfXnC/
m3rYu2pk6vYPoM6YFFnUnlM=
=MEmN
-----END PGP SIGNATURE-----

--=-RBN1bAIO/fIaJR40kFCy--


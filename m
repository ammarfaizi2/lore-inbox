Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVF3QG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVF3QG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVF3QG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:06:26 -0400
Received: from nysv.org ([213.157.66.145]:28053 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S263009AbVF3QDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:03:08 -0400
Date: Thu, 30 Jun 2005 19:02:44 +0300
To: shevek@bur.st, linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050630160244.GV11013@nysv.org>
References: <1120134372.42c3e4e49e610@webmail.bur.st> <20050630153326.GB24468@voodoo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pP8l8ytKVQui4K7o"
Content-Disposition: inline
In-Reply-To: <20050630153326.GB24468@voodoo>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pP8l8ytKVQui4K7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2005 at 11:33:26AM -0400, Jim Crilly wrote:

>> I label according to the observed effect. I haven't read the code.
>Of course not, it's not like the code actually matters, right?

As for Reiser4, they're fixing the code now to look more Linuxy
and all's well.

The discussion is "Should the VFS be extended to support files-as-dirs
or data objects by using what we already have in Reiser4 in -mm, although
disabled."

>So? Most of the complaints about Linux on the desktop are userland
>problems. Adding cool features to the kernel won't make a big difference,
>if for no other reason than it will take a long time for support to make it
>into things like Gnome and KDE. And that's if they choose to support them,

And people who'd like to use something lighter than Gnome or KDE
and still use these nice features?

>they have to support other OSes as well and adding support for features
>that are Linux-specific isn't to be taken lightly, especially since these
>would be less than Linux-specific, they would be tied to a single
>filesystem on Linux.

They would not be tied to a single filesystem, naturally, I think
we can all agree that case is closed, as it'll just spawn another
waste-of-time flamewar.

>> Someone shoulda simply forked it then. When Hans first said 'replace VFS=
 with
>> reiser4'. I doubt he could have done it by himself ... they (trolls) wou=
ld
[...]
>He can still do that, nothing is stopping him from forking Reisux and
>trying to woo developers.

It'd be much better to talk this thing through..
There have been pretty good arguments for the extended VFS, that it
would be doable. It may just be less of a unix after that, or less
of Linux as we know it now.

The circular reasoning "We don't want Reiser4's files-as-dirs in
before they're tested. We also have them disabled by default.
They should not be implemented on this layer here, but we won't
let you touch our VFS." is bad.

Surely if the things started to go into the VFS in a separate,
official tree, it'd no longer be just Namesys doing the work.

>And what is better for Linux? It's all about perspective and the people on
>this mailing list have to maintain the kernel from a developer's standpoint
>and if they start accepting every new feature regardless of complexity,
>maintainability, etc the kernel will become a nightmare.=20

The filesystem is tested well enough to go in. For real.
It may not be production stable with immediacy but it is tested.

The extended semantics are a separate matter.

>And what happens in 2 years when Hans posts about reiser5 fixing all of the
>bad things about reiser4 and that reiser5 should be merged ASAP so that
>everyone can upgrade again?

Then someone steps up and goes "No, shut the fuck up and fix the code,
we gave you your shot" or something.

Community pressure.

And it'll be a lot easier with the new VFS.

>And you're asking the kernel devs to get a wider scope on life? It sounds
>like you're not even living in the same reality that I am.

Sometimes it also seems people would much rather shout at each
other than see that reasons are starting to pop up why Linux
could lose popularity.

I accidentally deleted the paragraph with you saying the page
reads like a commercial.

I half agree, Hans has written that well, but maybe for
people who would pay him money to do his work.
Therefore some of the stuff is a bit obscure. Like what is now=20
Reiser4.1 (ie. ..metas/ whatever, I believe) is apparently referred=20
to as Reiser6 there.

It'd be damned nice to see that page revisited a bit, maybe not much,
but getting the names straight and having one of the tech guys write
tech documentation that's clearly accessible.

That page does still not change the situation that the code exists
to some extent, which could be merged to the VFS layer by
extending it a bit and this would be easiest done in a tree that
people will want to hack on.

And frankly this amount of tautology is starting to get even=20
on my nerves :)

--=20
mjt


--pP8l8ytKVQui4K7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCxBekIqNMpVm8OhwRAuCHAKCRqnLQy4J+lShDOHL0kgaYT6BoeQCfaxLa
Uy+UNEAcYFai3HQrcnH/SBw=
=+IW2
-----END PGP SIGNATURE-----

--pP8l8ytKVQui4K7o--

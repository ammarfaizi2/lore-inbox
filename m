Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWGYXwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWGYXwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWGYXwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:52:00 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:55006 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1030261AbWGYXv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:51:59 -0400
Message-ID: <44C6AE9E.6020300@slaphack.com>
Date: Tue, 25 Jul 2006 18:51:58 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060708)
MIME-Version: 1.0
To: Russell Cattelan <cattelan@thebarn.com>
CC: Hans Reiser <reiser@namesys.com>, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org>	 <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org>	 <44C32348.8020704@namesys.com> <1153854781.5893.5.camel@xenon.msp.redhat.com>
In-Reply-To: <1153854781.5893.5.camel@xenon.msp.redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig09C515B588B4628BFAC8AD6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09C515B588B4628BFAC8AD6D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Russell Cattelan wrote:
> On Sun, 2006-07-23 at 01:20 -0600, Hans Reiser wrote:
>> Jeff, I think that a large part of what is going on is that any patch
>> that can be read in 15 minutes gets reviewed immediately, and any patc=
h
>> that is worked on for 5 years and then takes a week to read gets
[...]
>> It is importand that we embrace our diversity, and be happy for the
>> strength it gives us.  Some of us are good at small patches that evolv=
e,
>> and some are good at escaping local optimums.  We all have value, both=

>> trees and grass have their place in the world.
>>
> Which is summed up quite well by:
> http://en.wikipedia.org/wiki/Color_of_the_bikeshed
>=20
> It seem to be a well know tendency for people to want to
> be involved in some way, thus keeping to much of the development
> cycle internal tends to generate friction.

No, I think Hans is right.

Although I should mention, Hans, that there is a really good reason to
prefer the 15 minute patches.  The patches that take a week are much
harder to read during that week than any number of 15 minute incremental
patches, because the incremental patches are already broken down into
nice, small, readable, ordered chunks.  And since development follows
some sort of logical, orderly pattern, it can be much easier to read it
that way than to try to consider the whole.

Think of it this way -- why are debuggers useful?  One of the nicest
thing about a debugger, especially for newbies, is the ability to step
through a program a line at a time.  It's the same principle -- you can
understand the program state at one point in time, and the impact of one
line of code, much more easily than the overall model of the program
state (and all of its edge cases), or the impact of several hundred
(thousand? tens of thousands?) lines of code.

So while I don't blame the Namesys team for putting off inclusion till
it's done, I also can't really blame the kernel guys for not wanting to
read it, especially if it's revolutionary.  Revolutionary ideas are hard
to grasp, and it's not their fault.

I mean, if revolutionary ideas were easy, why didn't you write Reiser4
for a system like, say, Tunes? (http://tunes.org/)  Say what you will,
but there are ways of doing fast filesystems which don't require that
said filesystems be written in kernel C.  Consider this:

http://www.cs.utah.edu/flux/oskit/

If I understand that right, it's a mechanism for writing kernel code in
languages like "Java, Lisp, Scheme, or ML"...

If we could all grasp every single good (best) idea from every corner of
software engineering, and write completely new software (including the
OS) using those ideas, we could potentially replace all existing
software in something like 3-5 years with software which has none of the
problems ours does now.  We'd never have inflexibility, insecurity,
instability, user interface issues...  Never have to worry about getting
software out the door (it'd be so fast to develop), but always have it
designed the right way the first time, yet be able to rearrange it
completely with only 5-10 line patches.

So it's not always the computer hardware that's the limitation.  Often
it's our hardware as well.  Human beings usually aren't equipped to be
able to grok the whole universe all at once.  If we were...  see above.


--------------enig09C515B588B4628BFAC8AD6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMaunngHNmZLgCUhAQqUVQ/+L6SO1vV7zFCNPt7Cm2NJ3Dfv9BsAlLH5
qORxH3+yGiALBHjce2p/i64bwA0KTgOJAWYOX0EGbwdapmOrCFOjb1QsiFj9/y61
ZXLzG/bO/cNItqBPzzaoMNErAVwHPfWwsY0roxJTZlh/LT4TXpCkcmYbW/lW/Lw9
tR/d+UHjGpmGYIBqIJ5sGrPVVRnQdUc8c9OX0SBEd6E4wINNWONkH8WJQhbikP/i
4X45GtZxJzc31FEFmV5eASvg/eoCU5JgXbqSAXL7Y+MNNnqO6DjNijFoFhjlmZt3
E0IwqZ5xyUgFOVeArtb6Er9beqbUHA8MbuEOXzyOZmOtcOo6kuOy50KQHGHmUn5G
dpH+DO3Xfr7sHN8EPbW5pvndrZ8QoaCX1bXpgjdc0hDpKkQ2qNtCuBQYyDyEqXBA
Q2VVbbG8ukPVSUN3HQbT+AFA6ZLF13KBHskYmx9v5K/vhu0ekm8DcgL/Yg3slfL6
aa95uBW6DXcdbExW/Sry9WPt+GLk2WyTq5qgwz6zzt5gLjv7L6nFjXXbCzqolDMV
hbon+I4BZJ2X1VM19pOB6Xum7JXLRQqtRbvRYWQnTSO+2UHx4gdDeWrP1VJuXJnK
USZuP4boXYaprf1dcZ8P57Z10sLn268z7vFsYkw3nuWPuYbLSd09cbPkxOeE1Qhf
BXb0ZHLh8z8=
=HlU6
-----END PGP SIGNATURE-----

--------------enig09C515B588B4628BFAC8AD6D--

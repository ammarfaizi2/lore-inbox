Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUHZOhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUHZOhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUHZOex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:34:53 -0400
Received: from dhcp160178161.columbus.rr.com ([24.160.178.161]:33293 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S268965AbUHZOdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:33:35 -0400
Date: Thu, 26 Aug 2004 09:05:56 -0400
From: Joseph Fannin <jhf@rivenstone.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826130556.GA11496@samarkand.rivenstone.net>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Nicholas Miell <nmiell@gmail.com>,
	Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
	Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
	torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20040826053200.GU31237@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 26, 2004 at 12:32:00AM -0500, Matt Mackall wrote:

> What it breaks is the concept of a file. In ways that are ill-defined,
> not portable, hard to work with, and needlessly complex. Along the
> way, it breaks every single application that ever thought it knew what
> a file was.
>=20
> Progress? No, this has been done before. Various dead operating
> systems have done it or similar and regretted it. Most recently MacOS,
> which jumped through major hurdles to begin purging themselves of
> resource forks when they went to OS X. They're still there, but
> heavily deprecated.
>=20
> > cp, grep, cat, and tar will continue to work just fine on files with
> > multiple streams.
>=20
> Find some silly person with an iBook and open a shell on OS X. Use cp
> to copy a file with a resource fork. Oh look, the Finder has no idea
> what the new file is, even though it looks exactly identical in the
> shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
> fork. How is that ever going to work?

   I've been known to be silly now and then, for sure.  Apple says
this about the next version of OS X, due next year:

"Tiger provides a standard, Darwin-level API for managing resource
forks, filesystem metadata, security information, properties and other
attributes in a consistent, cross-platform manner. For example, common
UNIX utilities such as cp, tar and rsync can properly handle HFS+
resource forks."

    That's marketing copy, but I think it's worth noting.  It seems to
be that resource forks aren't deprecated across the board,
just... changed.

    Apple has found a way to make this work, at least partially.  I
don't know if it's a good way, but there it is.

    I'd like to be able to keep my Macintosh stuff on my Linux
fileserver, without losing the resource forks.  That would require
that the network fs support it of course, and whether I could use tar
to back up my linux box would depend on how streams might be
implemented there.

> I like cat < a > b. You can keep your progress.

    Can't we have both?

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBLeA0Wv4KsgKfSVgRAoaEAJ0UlPMzaZo9sbDewdYLHWcrlceigQCffcYU
SsoR9eWCFAxk4hqRQiQwkLA=
=QKhw
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbTAOVuz>; Wed, 15 Jan 2003 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTAOVuz>; Wed, 15 Jan 2003 16:50:55 -0500
Received: from grendel.firewall.com ([66.28.56.41]:7902 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S267351AbTAOVuy>; Wed, 15 Jan 2003 16:50:54 -0500
Date: Wed, 15 Jan 2003 22:59:40 +0100
From: Marek Habersack <grendel@caudium.net>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: XFS problems (hard lockup and oops on startup) with 2.5.5{6,7}
Message-ID: <20030115215940.GA1441@thanes.org>
References: <20030114175528.GA1213@thanes.org> <20030115202134.A25143@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20030115202134.A25143@infradead.org>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2003 at 08:21:34PM +0000, Christoph Hellwig scribbled:
[snip]
> > check the first filesystem the kernel oopses with Oops code 0002, in the
> > interrupt handler. Nothing gets logged, of course, so I can't provide t=
he
> > full backtrace right now - I'll try to get it logged through the serial=
 console
> > if it happens again with 2.5.58. I have copied some values by hand from=
 the
> > screen (until I lost patience... :)):
> >=20
> > Unable to handle kernel paging request at virtual address 000500074
> >  printing EIP
>=20
> Hmm, that's really no much info.  And there weren't any XFS changes from
> 2.5.52 to 2.5.58..
Yep, that's why I wrote about something that affected XFS - at first I
thought it might have been preemption but then I checked I had it on also on
2.5.55. I'm running 2.5.58 currently and should the oops happen again, I'll
either transcribe the screen or get a screenshot via serial console. The
only thing I added in my > .55 config was the freebsd slice support and the
UFS support (as the module), but I doubt that would be the cause, although,
who knows?

thanks,

marek

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JdnMq3909GIf5uoRAqcMAJ4m3rNpv4l3zAqqVOj464dQhbLo7gCdEq+T
7/0gAopmf6+g1GhWdJnNQGU=
=/4UY
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

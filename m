Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUJTOyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUJTOyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUJTOoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:44:05 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:50897 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261474AbUJTOnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:43:18 -0400
Date: Wed, 20 Oct 2004 16:42:33 +0200
From: Martin Waitz <tali@admingilde.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ryan Anderson <ryan@michonline.com>, "Jeff V. Merkey" <jmerkey@drdos.com>,
       Dax Kelson <dax@gurulabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
Message-ID: <20041020144233.GK3618@admingilde.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Ryan Anderson <ryan@michonline.com>,
	"Jeff V. Merkey" <jmerkey@drdos.com>, Dax Kelson <dax@gurulabs.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <1098245904.23628.84.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Oct 20, 2004 at 12:18:25AM -0400, Lee Revell wrote:
> I was doing this with perl and SQL before I
> ever heard of RCU.  If you don't want to lock a table (or didn't realize
> SQL had such a thing as table locking :-) you just fetch a value, make
> some calculation on it, then do the update iff that value has not
> changed.  If it has changed you fetch the new value and go back to step

what you described is not RCU.
it's more something like seqlocks

RCU means: you always read without any locking.
when you want to write, you create a new copy of the data instead
and switch over a pointer when you are done.
if you are sure that the old pointer is not used any move, you can
free the old value.

--=20
Martin Waitz

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBdnlYj/Eaxd/oD7IRArVAAJ9aZDE3nD2iNhT6ooJu1+WjhJV15wCfaUF9
bfPbbzp+5Nx/PmPBjF1A5lY=
=TZI8
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRH0WBf>; Mon, 27 Aug 2001 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269387AbRH0WBZ>; Mon, 27 Aug 2001 18:01:25 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:49412 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S269372AbRH0WBP>; Mon, 27 Aug 2001 18:01:15 -0400
Date: Tue, 28 Aug 2001 00:01:27 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: memcpy to videoram eats too much CPU on ATI cards (cache trashing?)
Message-ID: <20010828000127.M17545@shurdeek.cb.ac.at>
In-Reply-To: <E15bRy4-0004Va-00@the-village.bc.nu> <200108272140.XAA20798@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RNRUMt0ZF5Yaq/Aq"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200108272140.XAA20798@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Mon, Aug 27, 2001 at 11:40:44PM +0200
X-Operating-System: Linux shurdeek 2.4.3-20mdk
X-Editor: VIM - Vi IMproved 6.0z ALPHA (2001 Mar 24, compiled Mar 26 2001 12:25:08)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2001 at 11:40:44PM +0200, Rogier Wolff wrote:
> However, as the X server manages to finish doing what it has to do before
> the next timer tick, it will almost never get a timer tick accounted to i=
t.
Yes, I also realised that, and other people also seem to think it is this w=
ay.

So the conclusion is basically that the card can't chew data that fast and I
should use busmastering instead of memcpy (and other drivers should do that
too because "hidden load" occurs anyway). I'm working on it.

Thanks to all who replied, I am as always pleased by the cooperation in
open-source world and wish everyone good luck. Yeah, and linux rocks of cou=
rse
:-)

> 			Roger.=20
Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505=
122023

--
               I believe the technical term is "Oops!"

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7isM3zogxsPZwLzcRAgXzAKCHnTTIGYjT9aR40gPOm6ccJxXi6wCfa08m
s5MbnsZx7O7rCCepVt8sehg=
=TPst
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTIBI34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTIBI34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:29:56 -0400
Received: from main.gmane.org ([80.91.224.249]:41933 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263627AbTIBI3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:29:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Fix up power managment in 2.6
Date: Tue, 02 Sep 2003 03:29:51 -0700
Message-ID: <m21xuzjxeo.fsf@tnuctip.rychter.com>
References: <20030901211220.GD342@elf.ucw.cz> <Pine.LNX.4.44.0309011509450.5614-100000@cherise>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:lzIwgPZuiAOCznDwZB5B+LP/Ft4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Patrick" =3D=3D Patrick Mochel <mochel@osdl.org>:
[...]
 Patrick> Power management has not worked for a majority of users for a
 Patrick> long time. It's in dire need of someone with motivation,
 Patrick> direction, and the time to make it work properly, and get it
 Patrick> on par with some of our contemporary OSes. I'm trying to be
 Patrick> that person, and actually fix things in the long run, rather
 Patrick> than encouraging people to "fix it themselves".
[...]

I'd like to throw in some comments from a user's point of view.

I've been using software suspend for quite a long time now. I was happy
when Pavel made it work back when he first got to it. I was a bit less
happy when it turned out that it doesn't really work all that well. Then
I was happy again when Nigel Cunningham put in a *lot* of hard work
(which he still does now) and made the 2.4 swsusp code nice and
stable. The result of Nigel's work is code that allows me 2-3 weeks of
uptime on my laptop with several suspends a day.

In the meantime, the 2.5 version hasn't really gone anywhere
interesting. It did not work for me when it was first merged, and it did
not work in -test3 either. People reporting problems were mostly told to
fix things themselves (which shows a blatant disregard for testers'
time, a common pitfall for people that write code).

Being a maintainer IMHO means fixing things, not standing in an ivory
"maintainer" tower and shouting at people.

Therefore, I couldn't agree more with Patrick. I am very happy to see
that someone actually cares about the code, tries to clean it up and fix
things. I hope things _will_ get fixed over time. And I certainly think
that Patrick's cleanups and refactoring are better than the constantly
broken state that software suspend was in.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VHEhLth4/7/QhDoRAkOvAKCDKDrrt96mig9S+DLo1Wg7EAIMUwCffPGx
GYfpmVQ3Ifn7UhN5Bf/AGeg=
=legi
-----END PGP SIGNATURE-----
--=-=-=--


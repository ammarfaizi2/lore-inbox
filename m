Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTLRJLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 04:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTLRJLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 04:11:39 -0500
Received: from user-0vvdbeo.cable.mindspring.com ([63.246.173.216]:20610 "EHLO
	zagar.linux-dude.net") by vger.kernel.org with ESMTP
	id S264957AbTLRJL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 04:11:26 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: Randy Zagar <jrzagar@cactus.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JcVKjaMENBAfoYjZjcjx"
Organization: 
Message-Id: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-1.9) 
Date: 18 Dec 2003 03:12:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JcVKjaMENBAfoYjZjcjx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry to be such a late-comer to this thread, but I think there is a way
to slice this without leaving lots of blood on the floor...  only just a
little.

As I see it, this whole problem about kernel headers revolves around the
argument that the header files are copyrighted and licensed under the
GPL, so if you incorporate portions of the kernel headers in your binary
module then it's considered a derivative work and must be GPL'd.

I have no problem with this, provided that the fragments of the header
files that make it through the compiler can actually have a valid
copyright.

The one example that was mentioned in the thread was the fact that the
phone book is copyrighted, but the phone numbers are not.  The factual
content is not copyright-able.

The other example, not mentioned in this thread is Westlaw.  They take
public court documents, annotate them, and publish them with page
numbers and page references.  The publication page references are their
contribution to the work and they've been able to maintain their
monopoly by squashing people who re-publish their page references
without their permission.

Here's the catch.  If I took one of their books, removed all page
references, made 10,000 copies, and sold it on the street for $10 per
copy they would not be able to sue me for copyright infringement because
I'm not distributing anything that they have copyrights to.

Same thing with the phone book.  If I ran the phone book through a
program and stripped out everything except the names and phone numbers,
I could repackage it, resell it, and never be guilty of copyright
infringement because all I did was redistribute something that couldn't
be copyrighted...  factual content.

My point is this:

Not all of the lines in a header file can have a valid copyright....=20
Some of the content is merely factual, and some other parts are trivial
math.  Programmer comments are definitely copyrightable, but those are
stripped out by the compiler.

The question boils down to this:

For a header file, does anything truly worthy of copyright actually
survive the compilation process?

If the answer is no, then a binary module cannot be a derivative work.=20
If the answer is yes, then it is.

The only way we're ever going to get a definitive answer is when this
actually goes to court.

But I don't think the answer will be very illuminating...  It'll be like
the time a Jesuit asked Richard Feynman if electricity was a form of
fire, Feynman answered no, but it turns out the Jesuit was only asking
the question so he would know whether or not it was moral to push
elevator buttons on the sabbath.

My $0.02,

-RZ

p.s.  The first thing I'm going to do after I build my time machine is
go visit Finland and say "Use the LGPL, Linus".


--=-JcVKjaMENBAfoYjZjcjx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/4W9grJr8p/YoerERAtqtAKCneV8s6EnhtJXvuPF8hghANn+7qACeKrP7
S48ln1HXMFU7sC473HBHuBM=
=GFfp
-----END PGP SIGNATURE-----

--=-JcVKjaMENBAfoYjZjcjx--


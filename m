Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264879AbUE0QgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUE0QgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUE0QgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:36:22 -0400
Received: from hostmaster.org ([212.186.110.32]:47752 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264879AbUE0QgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:36:16 -0400
Subject: Re: CONFIG_IRQBALANCE for AMD64?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <40B578F1.3090704@pobox.com>
References: <1085629714.6583.12.camel@hostmaster.org>
	 <40B578F1.3090704@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1farzHfqEMEOzz0f42e/"
Message-Id: <1085675774.6583.23.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 18:36:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1farzHfqEMEOzz0f42e/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Don, 2004-05-27 at 07:13, Jeff Garzik wrote:
> Why do you think you need in-kernel irq balancing?

Very good question indeed, why is it there for the i386 architecture at
all?

I just don't like the idea of unnecessary branching for the AMD64
architecture increasing maintenance and testing affords and thereby
generating less maintained and tested code.

> Does userspace irqbalanced not work for you?

Seems to work, just like the i386 irqbalanced before it has been
obsoleted by CONFIG_IRQBALANCE

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Press any key to continue or any other key to quit.

--=-1farzHfqEMEOzz0f42e/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQLYY/mD1OYqW/8uJAQL8AAf+I4pNTpGe9SP5dTKfx4LD9kaL38ZOnxXf
jv6KqGjj0Jraq3ysA8OUgLTarBBgseWOmtpgMLOdlk1lYRwPSqTQwc6WlIiXW+aG
diVdeHF6v5nUzy105j3kKQkK95OxAfgZRJjEE6/XxhphHSNHzoYffXzwue+gfvbx
El1bKn1XiAKIYBB1ij/6yW9aIE0gRtamy0wG8fOixkQkstw7EE0fgd9Ijs21YRzg
XlKUDdXKnF33kZtUkGM7lcY7mUt6l4lbrk93sg9opzL6AG6ylC+jitSsdR8hqXzr
usYZ1zSvhob/OLnP32yhfEPM/n4TYhuhhs2mfykb6zKxFDI8V8bmgg==
=QtXC
-----END PGP SIGNATURE-----

--=-1farzHfqEMEOzz0f42e/--


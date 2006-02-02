Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWBBMlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWBBMlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWBBMkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:40:47 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:40379 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750998AbWBBMko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:40:44 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 21:44:35 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012245.06328.nigel@suspend2.net> <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
In-Reply-To: <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3627319.XyGY0zQXGZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022144.40238.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3627319.XyGY0zQXGZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > +
> > +static inline void suspend_initialise_module_lists(void) {
> > +       INIT_LIST_HEAD(&suspend_filters);
> > +       INIT_LIST_HEAD(&suspend_writers);
> > +       INIT_LIST_HEAD(&suspend_modules);
> > +}
>
> I couldn't find a user for this. I would imagine there's only one,
> though, and this should be inlined there?

I forgot to mention re this - yes, there's just one caller, in another set =
of=20
patches I'll send later (this was just the first set!). Having the function=
=20
to be inlined in this .h so that it's with other module specific code, and=
=20
then used in the caller once it has been #included, isn't that the right wa=
y=20
to do things?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3627319.XyGY0zQXGZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4fCoN0y+n1M3mo0RAkRUAJ4jaHy/sxEv6k2qHiEdpDZWfYkkaQCgyb9k
GF0P4o5hlODbHlahdf1fAbo=
=XCkx
-----END PGP SIGNATURE-----

--nextPart3627319.XyGY0zQXGZ--

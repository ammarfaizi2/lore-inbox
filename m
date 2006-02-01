Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422946AbWBAVfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWBAVfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422947AbWBAVfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:35:20 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:41355 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422946AbWBAVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:35:19 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h'
Date: Thu, 2 Feb 2006 07:31:53 +1000
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012245.06328.nigel@suspend2.net> <Pine.LNX.4.58.0602010909530.23607@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602010909530.23607@shark.he.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2659318.WJ4M92yQBq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602020731.58183.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2659318.WJ4M92yQBq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 03:12, Randy.Dunlap wrote:
> On Wed, 1 Feb 2006, Nigel Cunningham wrote:
> > On Wednesday 01 February 2006 22:32, Pekka Enberg wrote:
> > > On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > > Suspend2 uses a strong internal API to separate the method of
> > > > determining the content of the image from the method by which it is
> > > > saved. The code for determining the content is part of the core of
> > > > Suspend2, and transformations (compression and/or encryption) and
> > > > storage of the pages are handled by 'modules'.
> > >
> > > [snip]
> > >
> > > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > > >
> > > >  0 files changed, 0 insertions(+), 0 deletions(-)
> > >
> > > Uh, oh, where's the patch?
> >
> > Indeed! Oops! I think I've managed to put this in kmail without having =
it
> > mangled!
> >
> > Nigel
> >
> >
> > [Suspend2] kernel/power/modules.h
> >
> >  kernel/power/modules.h |  179
> > ++++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 179
> > insertions(+), 0 deletions(-)
> >
> > diff --git a/kernel/power/modules.h b/kernel/power/modules.h
> > new file mode 100644
> > index 0000000..ee34199
> > --- /dev/null
> > +++ b/kernel/power/modules.h
> > @@ -0,0 +1,179 @@
> > +/*
> > + * kernel/power/module.h
>
> wrong file name.

Oops. Thanks.

> > +enum {
> > +	FILTER_PLUGIN,
> > +	WRITER_PLUGIN,
> > +	MISC_PLUGIN, // Block writer, eg.
> > +	CHECKSUM_PLUGIN
> > +};
>
> Kernel comment style is /* ... */, not // (many places).

Hmm. Learnt that a while ago. Not sure how I missed this one :)

> > +	/* Bytes! */
>
> Drop the '!'.

:) Will do.

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2659318.WJ4M92yQBq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4SjON0y+n1M3mo0RArmmAKDNGGcqRX3eZcSv3TJFMFtmnwP6QgCfQ2J1
GxIXVFpmXnTYJNuLKWxe+qQ=
=8tJp
-----END PGP SIGNATURE-----

--nextPart2659318.WJ4M92yQBq--

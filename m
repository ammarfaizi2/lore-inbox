Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWCOVe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWCOVe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCOVe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:34:56 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:60621 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751494AbWCOVeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:34:36 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@suse.cz>
Subject: Re: does swsusp suck aftre resume for you? [was Re: Re: Faster resuming of suspend technology.]
Date: Thu, 16 Mar 2006 07:32:09 +1000
User-Agent: KMail/1.9.1
Cc: Stefan Seyfried <seife@suse.de>, ck@vds.kolivas.org,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315103711.GA31317@suse.de> <20060315175948.GB2423@ucw.cz>
In-Reply-To: <20060315175948.GB2423@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1360432.lz5NvdPaAF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603160732.15627.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1360432.lz5NvdPaAF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 16 March 2006 03:59, Pavel Machek wrote:
> On Wed 15-03-06 11:37:11, Stefan Seyfried wrote:
> > On Mon, Mar 13, 2006 at 12:36:31PM +0100, Pavel Machek wrote:
> > > Yes, I can do mem=3D128M... but then, I'd prefer not to code workarou=
nds
> > > for machines noone uses any more.
> >
> > I have machines that cannot be upgraded to more than 192MB and would
> > like to continue using them :-)
>
> Good :-).
>
> > > 3) Does it still suck after setting image_size to high value (no =3D>
> > > good, we have simple fix)
> >
> > no matter how high you set image_size, it will never be bigger than
> > ~64MB on a 128MB machine, or i have gotten something seriously wrong.
>
> No, you are right, but maybe 64MB image is enough to get acceptable
> interactivity after resume? I'd like you to check it.
>
> (It will probably suck. In such case, testing Con's patch would be
> nice -- after trivial fix rafael pointed out).

If you could also test suspend2, that would be good. I've gained some renew=
ed=20
motivation for getting it merged, and hearing that it still does better tha=
n=20
swsusp + extras would be helpful in building the case for it.

Regards,

Nigel

--nextPart1360432.lz5NvdPaAF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEGIffN0y+n1M3mo0RAqqfAJ0RUT01SzKeCilyugHFXkv7uFv26wCggX5+
UkVpB34r25yUIo58N7gib48=
=9UIE
-----END PGP SIGNATURE-----

--nextPart1360432.lz5NvdPaAF--

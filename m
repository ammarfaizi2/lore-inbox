Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWDRHO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWDRHO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDRHO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 03:14:56 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:37101 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750928AbWDRHOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 03:14:55 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060417213201.GC3945@localhost.localdomain>
References: <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
	 <1144941999.2914.1.camel@openx2.frec.bull.fr>
	 <20060417210746.GB3945@localhost.localdomain>
	 <1145308176.2847.90.camel@laptopd505.fenrus.org>
	 <20060417213201.GC3945@localhost.localdomain>
Message-Id: <1145344481.17767.1.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Tue, 18 Apr 2006 09:14:41 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/04/2006 09:17:21,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/04/2006 09:17:22,
	Serialize complete at 18/04/2006 09:17:22
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sIJqn6o0AzcjatoRdfqL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sIJqn6o0AzcjatoRdfqL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le lun 17/04/2006 =C3=A0 23:32, Ravikiran G Thirumalai a =C3=A9crit :
> On Mon, Apr 17, 2006 at 11:09:36PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-04-17 at 14:07 -0700, Ravikiran G Thirumalai wrote:
> > >=20
> > >=20
> > > I ran the same tests on a 16 core EM64T box very similar to the one
> > > you ran
> > > dbench on :). Dbench results on ext3 varies quite a bit.  I couldn't
> > > get=20
> > > to a statistically significant conclusion  For eg,
> >=20
> >=20
> > dbench is not a good performance benchmark. At all. Don't use it for
> > that ;)
>=20
> Agreed. (I did not mean to use it in the first place :).  I was just tryi=
ng=20
> to verify the benchmark results posted earlier)
>=20
> Thanks,
> Kiran

What is the good performance benchmark to know if we should use atomic_t
instead of percpu_counter ?

Regards,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-sIJqn6o0AzcjatoRdfqL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBERJHh9Kffa9pFVzwRAh53AJ92g8cNzw02LJfMmWVAvb/K8Ei2UwCeLm2f
ESXyPYTHgHMu34Ijs3l0DkE=
=fvDk
-----END PGP SIGNATURE-----

--=-sIJqn6o0AzcjatoRdfqL--


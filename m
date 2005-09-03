Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbVICAYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbVICAYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVICAYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:24:39 -0400
Received: from adsl-63-194-109-9.dsl.snlo01.pacbell.net ([63.194.109.9]:43712
	"EHLO deneb.condordes.net") by vger.kernel.org with ESMTP
	id S1161077AbVICAYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:24:38 -0400
From: "Joshua J. Berry" <condor-dev@condordes.net>
To: fuse-devel@lists.sourceforge.net
Subject: Re: FUSE merging? (why I chose FUSE over v9fs)
Date: Fri, 2 Sep 2005 17:24:12 -0700
User-Agent: KMail/1.8.91
Cc: Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu> <20050902153440.309d41a5.akpm@osdl.org>
In-Reply-To: <20050902153440.309d41a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4820854.hZKs8yq9NX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509021724.19561.condor-dev@condordes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4820854.hZKs8yq9NX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 02 September 2005 15:34, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Hi Andrew!
> >
> > Do you plan to send FUSE to Linus for 2.6.14?
=2E..
> I agree that lots of people would like the functionality.  I regret that
> although it appears that v9fs could provide it, there seems to be no
> interest in working on that.

I evaluated both v9fs and FUSE for my project (I don't want to link to it=20
until it does something actually useful ;) ) ... and it seemed that v9fs=20
just wasn't UNIXy enough for my purposes -- the Plan9 way and the UNIX way=
=20
were different enough to make me nervous.  I don't remember the specific=20
details (this was a few months ago), but I do remember that v9fs had no=20
extended attribute support, which was a showstopper for me.  Also, I=20
couldn't find any userspace library for writing 9P servers.

Others may have reached similar conclusions.  Or maybe FUSE is just=20
better-marketed. ;)

Either way, I am a happy FUSE user.  I think it offers things v9fs doesn't,=
=20
and I'd like to see it in mainline. :)

=2D- Josh

=2D-=20
Joshua J. Berry

"I haven't lost my mind -- it's backed up on tape somewhere."
    -- /usr/games/fortune

--nextPart4820854.hZKs8yq9NX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDGO0zaIxeYlQMsxsRAvvlAKCbBqQ4m0ZCWKZAhxu/dc6W0k1O5gCeIHd+
2zEJASlg+Jofbq08mAtjE/w=
=5Blq
-----END PGP SIGNATURE-----

--nextPart4820854.hZKs8yq9NX--

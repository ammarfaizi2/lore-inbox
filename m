Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTIEMZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTIEMZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:25:02 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:61825
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S262499AbTIEMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:24:59 -0400
Date: Fri, 5 Sep 2003 14:25:01 +0200
To: John Bradford <john@grabjohn.com>
Cc: joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030905122501.GA3250@leto2.endorphin.org>
References: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063628701.d72f@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2003 at 01:25:24PM +0100, John Bradford wrote:
> > > Are there any buffer overflows or other security holes?
> > > How can you be sure about it?
> >
> > How can you be sure? Mathematical program verification applies quite ba=
dly
> > to assembler.
>=20
> The point is, if somebody does find a bug they will want to
> re-assemble with Gas after they've fixed it.

If you referring to my precompiled masm binaries, yes, if one wants to
change the source, getting masm is not nice.

But if the source is writting in nasm, nasm (LGPL) can be installed
easily..=20

However, the kernel folks seem to dislike to depend on an additional tool.
Actually that's the answer to my original question. Now I just have to
ponder if I favour the preferences of the kernel over the prefs of user spa=
ce
programs. There are lots of user space crypto implementations, which are
potential candidates.. and for theses apps an additional dependency on nasm
is no problem.

Regards, Clemens

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/WICdW7sr9DEJLk4RAluPAJwMwLNNSlT2rc3WfSafPhMFsBMmywCgkEn1
0bzcn991DbapHo82cZLq0bY=
=VlrY
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbTIEMEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIEMEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:04:48 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:53377
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S262468AbTIEMEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:04:45 -0400
Date: Fri, 5 Sep 2003 14:04:46 +0200
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030905120446.GA3111@leto2.endorphin.org>
References: <20030904104245.GA1823@leto2.endorphin.org> <20030905114220.GB10415@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20030905114220.GB10415@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063627487.e072@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2003 at 01:42:20PM +0200, J=F6rn Engel wrote:
> On Thu, 4 September 2003 12:42:45 +0200, Fruhwirth Clemens wrote:
>
> Do some benchmarks on lots of different machines and measure the
> performance of the asm and c code.  If it's faster on PPro but not on
> PIII or Athlon, forget about it.
>
> How big is the .text of the asm and c variant?  If the text of yours
> is much bigger, you just traded 2fish performance for general
> performance.  Everything else will suffer from cache misses.  Forget
> your microbenchmark, your variant will make the machine slower.

Men! Why is everyone doubting the usefulness of assembler optimized parts?
It's twice as fast on my Athlon. I assert the same is true for P3/P4. Just
test.

twofish-i586.ko's .text section is smaller than the kernel's twofish.ko's. =
945
bytes to be precise. Please note that twofish-i586 includes TWO
implementations: C and assembler. Just think about how much smaller it will
be when I rip out the C part.=20

So much for that.

> How many bugs are in your code? =20

42... Is this a serious question?

> Are there any buffer overflows or other security holes?=20
> How can you be sure about it? =20

How can you be sure? Mathematical program verification applies quite badly =
to
assembler.

> If your code fails on any one of these questions, forget about it.  If
> it survives them, post your results and have someone else verify them.

I'm sorry, your critique is too generel to be useful.

Regards, Clemens

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/WHveW7sr9DEJLk4RAjpdAKCU95q/hufW8F70nFcusfoJvwcBzQCcCtJZ
PSfNHYVKwCwdiAhGFdf9O+s=
=IKEc
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTDSXLH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 19:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTDSXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 19:11:07 -0400
Received: from dsl-217-155-72-205.zen.co.uk ([217.155.72.205]:12552 "EHLO
	nicole.computer-surgery.co.uk") by vger.kernel.org with ESMTP
	id S263496AbTDSXLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 19:11:06 -0400
Date: Sun, 20 Apr 2003 00:22:17 +0100
To: mikpe@csd.uu.se
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI cdrecord issue 2.5.67
Message-ID: <20030419232217.GA6873@computer-surgery.co.uk>
References: <1049983308.888.5.camel@gregs> <1049984188.887.11.camel@gregs> <1049986391.599.6.camel@teapot.felipe-alfaro.com> <20030410193420.GD429@vitelus.com> <b74i32$58g$1@cesium.transmeta.com> <1050003892.12498.45.camel@dhcp22.swansea.linux.org.uk> <16022.40189.672337.427776@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <16022.40189.672337.427776@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2003 at 12:46:21PM +0200, mikpe@csd.uu.se wrote:
> Alan Cox writes:
>  > On Thu, 2003-04-10 at 20:53, H. Peter Anvin wrote:
>  > > I think ide-scsi needs to be supported for some time going forward.
>  > > After all, cdrecord, cdrdao, dvdrecord aren't going to be the only
>  > > applications.
>  >=20
>  > And far longer than that. People seem to be testing and demoing=20
> [snip]
>=20
> ATAPI tape drives will need ide-scsi too, unless ide-tape somehow
> got repaired lately. And some people already use ide-scsi+st in
> 2.4 since ide-tape doesn't always work reliably.

Whan I last looked at the ide-tape driver  , which was
back in 2.2, it looked like the big problem was actually=20
in it error handling , rather than anywhere else.

I don't think it has been changed significantly it that regard
since.

IIRC , the behaviour which appeared to be caueing me a problem
was that some slow driver would be busy long for ide-tape to
get bored. It also didn;t like getting error codes which weren't
spelled out it the quik spec. The common travan mechanism I
get lots of here, spits out quite a few of those. (As well
as failing one of st's enquiry cmds).

TTFN
--=20
Roger. 	                        Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
   GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E
Work|Independent Systems Consultant | http://www.firstdatabase.co.uk/

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+odopqQ3nO4jeCz4RAsogAJ0VteBTY183SJ9mM8oEmPTffS393wCeN6UC
Nk6J7YS2H0NbreDGk2zganQ=
=ki8C
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

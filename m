Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUIHQH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUIHQH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUIHQHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:07:47 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:42415 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268844AbUIHQHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:07:08 -0400
Date: Wed, 8 Sep 2004 18:02:28 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Oliver Hunt <oliverhunt@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040908160228.GC2726@thundrix.ch>
References: <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com> <413829DF.8010305@hist.no> <20040905134428.GN26560@thundrix.ch> <413ECFD8.1040808@hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <413ECFD8.1040808@hist.no>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 08, 2004 at 11:24:40AM +0200, Helge Hafting wrote:
> If you can open a fork/substream/whatever by issuing
> open("filename/forkname", ...
> then the old-fashioned open() works with multi-fork files too.
> An tools based on "open() something, then work with
> the resulting file descriptor" will work _unchanged_
> with such a multi-fork fs.

In my version they'd run unchanged as well.

And  BTW,  I wasn't  talking  about introducing  a  new  open at  libc
level.  I was  talking about  modifying the  open system  call  in the
kernel and having libc provide compatibility for the old call.

Since  I'm not  sure  how much  breakage it  takes  to make  a file  a
directory.

			    Tonnerre


--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPy0U/4bL7ovhw40RAhPmAJwK/wFQaiypfxKf3HA+addCeMk8BACfaYuT
bSqujKHq5azTs7Sqol+gMWc=
=QBR7
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

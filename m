Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268098AbUHTO33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbUHTO33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHTO33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:29:29 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:26527 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268098AbUHTO3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:29:12 -0400
Date: Fri, 20 Aug 2004 16:28:40 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]Kexec based crash dumping
Message-ID: <20040820142840.GD16660@thundrix.ch>
References: <20040819083333.76F4.ODA@valinux.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20040819083333.76F4.ODA@valinux.co.jp>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Thu, Aug 19, 2004 at 08:45:00AM +0900, Itsuro Oda wrote:
> - prepare a kernel which does only dump real memory to block
>   device. ("dump mini kernel")
> - pre-allocate the memory (4MB is enough) used by the dump mini
>   kernel and pre-load the dump mini kernel.
> - when crash occur exec the dump mini kernel.
> - the dump mini kernel stands in and only uses pre-allocated
>   area.

One question, what  happens in your concept when  some stubborn zombie
kernel driver  (say Nvidia) comes  along and overwrites  random memory
areas? Will the booting of the dump kernel simply fail?

			    Tonnerre

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBJgqX/4bL7ovhw40RAjFpAJ4iCPr6Mb2NtfxWT9ntbbdTP++shgCgsOdT
hfV/3Z150rk3xjokx9aUgUM=
=2EI4
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

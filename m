Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTEVXeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTEVXeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:34:08 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:34950 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263445AbTEVXeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:34:05 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Error during compile of 2.5.69-mm8
Date: Fri, 23 May 2003 01:47:00 +0200
User-Agent: KMail/1.5.9
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
References: <20030522160218.57b828db.akpm@digeo.com> <200305230128.06412.schlicht@uni-mannheim.de> <20030522.162913.115921853.davem@redhat.com>
In-Reply-To: <20030522.162913.115921853.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_0FWz+mBJwbePR88";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305230147.00730.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_0FWz+mBJwbePR88
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On May 23, David S. Miller wrote:
>    From: Thomas Schlichter <schlicht@uni-mannheim.de>
>    Date: Fri, 23 May 2003 01:28:06 +0200
>
>    On May 23, David S. Miller wrote:
>    > Yoshfuji posted a patch on linux-kernel to fix this already.
>
>    Sorry, I must have missed this patch - that would have made my work
>    obsolete -
>    but I'd like to see how that supports all the other
>    SET_MODULE_OWNER calls from all the other places...
>
> They also should be converted to explicit ->owner references.

Well, I don't think so...
I don't like it if there is a possibility doing it with an initializer, but=
 in=20
other cases it may increase readability, too...

There was a discussion about SET_MODULE_OWNER here on the list, once.
You can find it here:

     http://marc.theaimsgroup.com/?t=3D104969843600002&r=3D1&w=3D2

At the end Rusty made a small patch that never made it into the mainline tr=
ee=20
(even if I think it should have...) His mail with the patch can be found at:

     http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D105065084724249&w=
=3D2

(I like the analogy to a mainframe ;-)

Best regards
   Thomas Schlichter

--Boundary-02=_0FWz+mBJwbePR88
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+zWF0YAiN+WRIZzQRAsnFAKCpDdOf+OLn0C71C7K3YKowLRu2KQCgjjcl
CI18IGLjYdN8VDxbf8s/uvM=
=sbHo
-----END PGP SIGNATURE-----

--Boundary-02=_0FWz+mBJwbePR88--

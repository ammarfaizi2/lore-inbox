Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUEJW2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUEJW2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUEJW2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:28:14 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:53679 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261989AbUEJW2I (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:28:08 -0400
Message-Id: <200405102227.i4AMRZH0005222@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1 
In-Reply-To: Your message of "Mon, 10 May 2004 15:02:03 PDT."
             <20040510150203.3257ccac.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org>
            <20040510150203.3257ccac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1017408894P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 May 2004 18:27:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1017408894P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 15:02:03 PDT, Andrew Morton said:

> > These two just introduced a subtile behaviour change during stable series,
> > possibly (not likely) leading to DoS opportunities from applications running
> > as gid 0.
> 
> mlock_group is likely to go away.
> 
> Is an unprivileged user likely to have gid 0?   Easy enough to fix, anyway.

Equally important, is gid 0 (with its other possible overloadings) something that we
want to put on a user just because they have a need for mlock??


--==_Exmh_1017408894P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoAHXcC3lWbTT17ARAhdbAJ9icGvzD48v113hCLtWns3BPgBG2wCg9arS
ZPeGs8m2xHvmlioxVAoMey8=
=moXW
-----END PGP SIGNATURE-----

--==_Exmh_1017408894P--

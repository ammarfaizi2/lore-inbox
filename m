Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbUEJXDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUEJXDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUEJXCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:02:55 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:47323 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261744AbUEJXB5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:01:57 -0400
Message-Id: <200405102301.i4AN1cYV023514@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1 
In-Reply-To: Your message of "Mon, 10 May 2004 15:48:00 PDT."
             <20040510154800.5a5183ea.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <200405102227.i4AMRZH0005222@turing-police.cc.vt.edu>
            <20040510154800.5a5183ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1224233908P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 May 2004 19:01:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1224233908P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 15:48:00 PDT, Andrew Morton said:

> You misread the code.  The sysctl, when non-zero, specifies the group which is
> allowed to allocate hugetlb-backed shm segments.

OK.. <mode="emily_litella">Nevermind</mode> :)

Using a group ID for this is still somewhat ugly (having just been looking at
similar weirdness in the grsecurity patch) - but at least groups are relatively
cheap and it's there now (as opposed to an rlimit-based solution)...


--==_Exmh_1224233908P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoAnScC3lWbTT17ARApC8AKDRW6zb5ADn8dhG+Z36yy6a4xXtyQCgvhhu
ZH+ZheUxnopI7D6JRO2/xzQ=
=HR8r
-----END PGP SIGNATURE-----

--==_Exmh_1224233908P--

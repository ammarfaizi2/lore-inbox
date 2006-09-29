Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161307AbWI2D6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbWI2D6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWI2D6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:58:12 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:63427
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161307AbWI2D6M (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:58:12 -0400
Message-Id: <200609290358.k8T3w1OV008852@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: Your message of "Thu, 28 Sep 2006 20:29:31 PDT."
             <20060928202931.dc324339.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu>
            <20060928202931.dc324339.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159502281_2840P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 23:58:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159502281_2840P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Sep 2006 20:29:31 PDT, Andrew Morton said:
> On Thu, 28 Sep 2006 23:19:11 -0400
> Valdis.Kletnieks@vt.edu wrote:
> 
> > On Thu, 28 Sep 2006 01:46:23 PDT, Andrew Morton said:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/

> > Something is giving cache_alloc_refill() massive indigestion, I'm taking
> > lots of oopsen in it.  Usually within 5-10 minutes I'm dead in the water.
> 
> Could be anything I'm afraid.  But you're the first to report it, so there's
> something distinct in your .config or hardware.

Like *that* hasn't happened before. :)

> bisecting would be good, thanks.  It might be quicker to strip down the .config
> though.

On the other hand, this really smells like the kind of storage overlay that
changing the config can change what gets overlaid, scaring it into hiding.
The fact the system lives 5-10 minutes means that there's *something* that
happens that makes it manifest - and that could be almost anything.

--==_Exmh_1159502281_2840P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHJnJcC3lWbTT17ARAlULAJ9KRvSa6+xGLo45oTK/5Q1P/s8flACfduQN
XA9bq9ZG4W4qYGzHBf+umz8=
=Tmzb
-----END PGP SIGNATURE-----

--==_Exmh_1159502281_2840P--

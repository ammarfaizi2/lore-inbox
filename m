Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTETATC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTETATC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:19:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56740 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262830AbTETATB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:19:01 -0400
Message-Id: <200305200031.h4K0VwPc025596@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-Reply-To: Your message of "Tue, 20 May 2003 10:08:46 +1000."
             <20030520001623.8BE182C0F9@lists.samba.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030520001623.8BE182C0F9@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1290529165P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 May 2003 20:31:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1290529165P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 May 2003 10:08:46 +1000, Rusty Russell said:
> In message <20030519111028.B8663@infradead.org> you write:
> > Urgg, yet another sys_futex extension.  Could you please split all
> > these totally different cases into separate syscalls instead?
> 
> I don't mind either way, but wouldn't that be pointless incompatible
> churn?

Doesn't matter, the churn hasn't been reflected in glibc-kernheaders yet
either way.  Once kernheaders gets updated to match, you're stuck with whatever
it is at that point, so churn now while you have a chance. ;)

(Sorry, I couldn't resist)

--==_Exmh_-1290529165P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+yXd9cC3lWbTT17ARAqpHAKDxfMgPinR1BsVeH1nAAkDhvv0C2wCgrmjB
PAStBuwat/6OI8xaSe0rvTI=
=Z9H6
-----END PGP SIGNATURE-----

--==_Exmh_-1290529165P--

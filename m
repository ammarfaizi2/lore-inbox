Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265252AbUFXN6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUFXN6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUFXN6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:58:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3456 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265252AbUFXN6D (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:58:03 -0400
Message-Id: <200406240607.i5O67uQ1020287@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Joshua Brindle <jbrindle@snu.edu>,
       "Serge E. Hallyn" <hallyn@CS.WM.EDU>
Subject: Re: [PATCH][SELINUX] Extend and revise calls to secondary module 
In-Reply-To: Your message of "Tue, 22 Jun 2004 10:49:45 EDT."
             <1087915785.6237.42.camel@moss-spartans.epoch.ncsc.mil> 
From: Valdis.Kletnieks@vt.edu
References: <1087915785.6237.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118315926P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Jun 2004 02:07:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118315926P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Jun 2004 10:49:45 EDT, you said:
> This patch extends the set of calls to the secondary security module
> by SELinux as well as revising a few existing calls to support other
> security modules and to more cleanly stack with the capability module.
> Please apply.
> 
> Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

Thank you.  :)

For those who tuned in late, this patch is a superset of a patch I had to make to
get some LSM work of mine to play nice with SELinux (my original request to the
SELinux crew included 2 other hooks which I since retracted, having found other
solutions).

It also addresses at least some of the things that Serge Hallyn was looking at
doing with some other LSM work, and also cleans up some issues for yet a third
thing that Serge and I were semi-collaborating on (no Serge, I hadn't forgotten
about that, I was sort of dragging my feet waiting for this patch to show up
and make my life a lot simpler.. ;)



--==_Exmh_1118315926P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA2m+7cC3lWbTT17ARAu9NAKDhms19Kd8RXLeVUAmjKD9rGf231QCg8dkh
pyTmsxm7IESUvr/sFHcMuU0=
=4sme
-----END PGP SIGNATURE-----

--==_Exmh_1118315926P--

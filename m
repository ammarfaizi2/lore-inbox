Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTJKRiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTJKRiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:38:17 -0400
Received: from h80ad24a2.async.vt.edu ([128.173.36.162]:33424 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263344AbTJKRiP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:38:15 -0400
Message-Id: <200310111738.h9BHcB6s027943@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: asdfd esadd <retu834@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model 
In-Reply-To: Your message of "Sat, 11 Oct 2003 10:13:55 PDT."
             <20031011171355.60258.qmail@web13008.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031011171355.60258.qmail@web13008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-367817594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Oct 2003 13:38:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-367817594P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Oct 2003 10:13:55 PDT, you said:
> 
> unfortunately it's rather a jump into elegance. The
> other OS component model is quite well architected.
> Hence what's needed is _a similar architecture effort
> which may _abstract many things in the beginning to be
> filled in later. Ther's a dire need for a sound and
> similarly elegant (or better) model. 

Two words: "syscall interface".

Most of what you're blathering about needs to happen in userspace.

If there's disagreement over what GUI style to use, the kernel is
NOT going to provide any guidance.  KDE versus Gnome versus the
other 23 window managers - that's all userspace.  The reason there's
25 window managers is because 25 sets of people had *different goals*.

The kernel wisely stayed *OUT OF THE WAY*.

With a single common object model, Linux can push the envelope in ONE
direction.  Which is why That Other System scales so incredibly well from
a Zaurus to a 128-CPU NUMA box, handles different GUIs for different goals,
and all the rest of that.....

--==_Exmh_-367817594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/iEABcC3lWbTT17ARAub5AKD86oC7fJ3P8R4VHhudNWHerlG5+QCgpXY8
zcM4xnRux4NKvvtMk06WKlA=
=oqhT
-----END PGP SIGNATURE-----

--==_Exmh_-367817594P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUEKXgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUEKXgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUEKXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:36:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10686 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265060AbUEKXep (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:34:45 -0400
Message-Id: <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dave Airlie <airlied@linux.ie>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sf.net
Subject: Re: From Eric Anholt: 
In-Reply-To: Your message of "Wed, 12 May 2004 00:20:51 BST."
             <Pine.LNX.4.58.0405120018360.3826@skynet> 
From: Valdis.Kletnieks@vt.edu
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <20040511222245.GA25644@kroah.com>
            <Pine.LNX.4.58.0405120018360.3826@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-479259688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 19:34:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-479259688P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 May 2004 00:20:51 BST, Dave Airlie said:

> I just looked at drm.h and nearly all the ioctls use int, this file is
> included in user-space applications also at the moment, I'm worried
> changing all ints to __u32 will break some of these, anyone on DRI list
> care to comment?

Is this a case where somebody is *really* including kernel headers in userspace
and we need to smack them, or are they using a copy that's been sanitized
(and possibly fixed)?

--==_Exmh_-479259688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoWMOcC3lWbTT17ARAk2jAJwPi4T3yzXF6z3u9o4bufzEhylEWACgiSxZ
qMlJhhyJtJ+MHCgfGNzlNcg=
=V4m6
-----END PGP SIGNATURE-----

--==_Exmh_-479259688P--

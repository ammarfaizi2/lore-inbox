Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVEBQmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVEBQmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVEBQ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:27:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33039 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261409AbVEBQPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:15:11 -0400
Message-Id: <200505021614.j42GEufG008441@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Matt Mackall <mpm@selenic.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark 
In-Reply-To: Your message of "Mon, 02 May 2005 11:49:32 EDT."
             <42764C0C.8030604@tmr.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050429203959.GC21897@waste.org> <20050429203959.GC21897@waste.org> <20050430025211.GP17379@opteron.random>
            <42764C0C.8030604@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115050495_5213P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 May 2005 12:14:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115050495_5213P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 May 2005 11:49:32 EDT, Bill Davidsen said:
> Andrea Arcangeli wrote:
> > On Fri, Apr 29, 2005 at 01:39:59PM -0700, Matt Mackall wrote:

> > -#!/usr/bin/python
> > +#!/usr/bin/env python
> >  #
> >  # mercurial - a minimal scalable distributed SCM
> >  # v0.4b "oedipa maas"
> 
> Could you explain why this is necessary or desirable? I looked at what 
> env does, and I am missing the point of duplicating bash normal 
> behaviour regarding definition of per-process environment entries.

Most likely, his python lives elsewhere than /usr/bin, and the 'env' call
results in causing a walk across $PATH to find it....

--==_Exmh_1115050495_5213P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCdlH/cC3lWbTT17ARAq/cAKDmu+G8AokTYiz085V8JCaAtT4ytgCg61Tn
JWb2Qqgasiqj2fy9vWns4so=
=xIsP
-----END PGP SIGNATURE-----

--==_Exmh_1115050495_5213P--

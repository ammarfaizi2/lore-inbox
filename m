Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWDSPvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWDSPvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDSPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:51:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40332 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750925AbWDSPvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:51:42 -0400
Message-Id: <200604191551.k3JFpHHV006213@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, casey@schaufler-ca.com,
       James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-Reply-To: Your message of "Wed, 19 Apr 2006 06:41:06 CDT."
             <20060419114106.GC20481@sergelap.austin.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com> <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com> <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
            <20060419114106.GC20481@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145461876_2985P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 11:51:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145461876_2985P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Apr 2006 06:41:06 CDT, "Serge E. Hallyn" said:
> Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> > On Wed, 19 Apr 2006 02:40:25 EDT, Kyle Moffett said:
> > > Perhaps the SELinux model should be extended to handle (dir-inode,
> > > path-entry) pairs.  For example, if I want to protect the /etc/shadow
> > > file regardless of what tool is used to safely modify it, I would set
> > 
> > Some of us think that the tools can protect /etc/shadow just fine on their
> > own, and are concerned with rogue software that abuses /etc/shadow without
> > bothering to safely modify it..
> 
> Can you rephrase this?  I'm don't understand what you're saying...
> 
> My default response would have to be:
> 
> > own, and are concerned with rogue software that abuses /etc/shadow without
> > bothering to safely modify it..
> 
> rogue software like vi?

Close enough.  I was actually thinking of a script kiddie with a canned tool
that does 'echo foo::0:0: >> /etc/passwd' type stuff, but vi without its vipw
component would count too....

--==_Exmh_1145461876_2985P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERlx0cC3lWbTT17ARAmu9AKDiM2CXvNS6o1jL+Zb80vvdLv1eKgCgmO+v
oej6Aa8iUWlPlZKDWKekMYw=
=ghJ0
-----END PGP SIGNATURE-----

--==_Exmh_1145461876_2985P--

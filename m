Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUJAUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUJAUlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUJAUjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:39:46 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1948 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266517AbUJAUeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:34:01 -0400
Message-Id: <200410012033.i91KXvXH028760@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: cranium2003 <cranium2003@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.linux.org
Subject: Re: Plzzz help me 
In-Reply-To: Your message of "Fri, 01 Oct 2004 13:11:18 PDT."
             <200410011311.22645.ryan@spitfire.gotdns.org> 
From: Valdis.Kletnieks@vt.edu
References: <20041001024136.96889.qmail@web41402.mail.yahoo.com>
            <200410011311.22645.ryan@spitfire.gotdns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2079495324P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Oct 2004 16:33:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2079495324P
Content-Type: text/plain; charset=us-ascii

On Fri, 01 Oct 2004 13:11:18 PDT, Ryan Cumming said:

> By definition, only hosts have IP addresses. Any router that has an IP address
> is also a host.

Very true - if it's a L3 router, it needs that IP address so you have something
to use as a 'next hop' when you try to send to it.  If it doesn't have an IP
address, it's a L2 switch/hub and you pretty much *don't* want to talk to it
at all (except to an IP set up as a "management" address, but then you're
talking to it as a host, of course)...

I *think* cranium2003 wanted to do different things depending on whether
the 'next hop addr == dest addr', but I'm failing to see any cases where
you'd want to do that....


--==_Exmh_-2079495324P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBXb80cC3lWbTT17ARAnOOAJwJflaVY82KJJumkx1TjMX8ZxhgXwCfVmX9
LTR/cODC8gpvZUgr1dwfi6s=
=LRdj
-----END PGP SIGNATURE-----

--==_Exmh_-2079495324P--

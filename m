Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTLEVQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 16:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTLEVQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 16:16:39 -0500
Received: from mail.willden.org ([63.226.98.113]:12424 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S264485AbTLEVQg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 16:16:36 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: David Schwartz <davids@webmaster.com>
Subject: Re: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 14:16:18 -0700
User-Agent: KMail/1.5.93
Cc: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKIEMGIHAA.davids@webmaster.com> <Pine.LNX.4.58.0312051210260.9125@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312051210260.9125@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200312051416.20783.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 05 December 2003 01:14 pm, Linus Torvalds wrote:
> On Fri, 5 Dec 2003, David Schwartz wrote:
> > Please show me the law
> > that permits a copyright holder to restrict the distribution of
> > derived works.
> 
> The "show me the law" is USC 17. It's called "US Copyright Law". As a
> copyright holder in the Linux kernel, I _do_ have the right to restrict
> the distribution of derived works. That's what copyright law is all
> about.

Actually, based on my understanding of Title 17 and the GPL (both of which 
I just re-read), David *almost* has a point.

1.  As David implies, Title 17 does not grant the copyright holder the 
right to restrict distribution of derived works.  Section 106[1] describes 
the exclusive rights granted to copyright holders, and it only says that 
they have exclusive rights to *prepare* derived works.  So you cannot 
create a derived work without permission from the copyright holder, but 
once you have obtained permission to create it, you can distribute the 
result.  Maybe.

2.  The copyright holder can grant permission to create derived works to 
whomever (s)he likes, under whatever terms (s)he likes (modulo other 
laws).  So, the copyright holder can attach strings to the permission.  
For example, the copyright holder could specify that you are allowed to 
create a derived work, but only on the condition that you do not 
distribute it.

3.  The GPL understands points 1 and 2, which is why section 2 of the GPL 
states:

	You may modify your copy or copies of the Program or any
	portion of it, thus forming a work based on the Program,
	and copy and distribute such modifications or work under
	the terms of Section 1 above, provided that you also meet
	all of these conditions:

It then lists three conditions, the most important of which is the second, 
which states that if the derived work is distributed, it must be 
distributed under the terms of the GPL.

IANAL, but the language in Title 17 and the GPL seems pretty clear.  If 
someone creates a derived work and distributes it under any terms other 
than the GPL, they have violated the agreement which gave them permission 
to create the derived work, and thereby infringed on the copyright 
holder's exclusive rights.

So, yeah, you *do* have the right to restrict distribution of derived 
works, via a thunk in the GPL.

Oh, IANAL.

	Shawn.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0PWip1Ep1JptinARAjhXAJ9x66s2KNm8KK4+9bNDBKOQ6Hd6YQCghXFD
Ju6LimWjD6NJJqsG4u7Jr7g=
=vop3
-----END PGP SIGNATURE-----

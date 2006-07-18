Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWGRDUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWGRDUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWGRDUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:20:19 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:22723
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750721AbWGRDUS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:20:18 -0400
Message-Id: <200607180320.k6I3K5dv007696@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Vishal Patil <vishpat@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic B-tree implementation
In-Reply-To: Your message of "Mon, 17 Jul 2006 23:08:53 EDT."
             <4745278c0607172008x3343f397l22e4bec1b297fd0f@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <vishpat@gmail.com> <4745278c0607171902pc218a9dn9c63dd6670ac7249@mail.gmail.com> <200607180258.k6I2wEFm012293@laptop11.inf.utfsm.cl>
            <4745278c0607172008x3343f397l22e4bec1b297fd0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153192805_3154P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jul 2006 23:20:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153192805_3154P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Jul 2006 23:08:53 EDT, Vishal Patil said:
> Agreed, however if I am not mistaken B-trees are useful even for
> virtual memory implementation, for example HP-UX uses B-trees for
> managing virtual memory pages.

OK, sounds at least somewhat plausible..

> Also I did not get the statement
> "Build infrastructure (== library) without clear users won't go very
> far on LKML"

Your patch would go a lot further if it came as 2 parts:

PATCH 1/2: Add Generic B-tree implementation
PATCH 2/2: Convert mm/foobar.c to track VM pages using B-trees.

Barring an actual patch 2/2, a *clear* explanation of why it would benefit
a *specific* piece of code so somebody else can do it...

--==_Exmh_1153192805_3154P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvFNlcC3lWbTT17ARAncvAJ0apxzUdQmodIf4Q9VFr4YPgX3howCeMV7J
5SbpgFu1WxNSv7zYqtgAYfQ=
=9NC5
-----END PGP SIGNATURE-----

--==_Exmh_1153192805_3154P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbTDSVER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTDSVER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:04:17 -0400
Received: from h80ad2453.async.vt.edu ([128.173.36.83]:28310 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263469AbTDSVEQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:04:16 -0400
Message-Id: <200304192115.h3JLFVuL018983@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept? 
In-Reply-To: Your message of "Sat, 19 Apr 2003 22:56:21 +0200."
             <20030419205621.GA15577@hh.idb.hist.no> 
From: Valdis.Kletnieks@vt.edu
References: <20030419180421.0f59e75b.skraw@ithnet.com> <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com> <20030419184120.GH669@gallifrey>
            <20030419205621.GA15577@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2122594070P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Apr 2003 17:15:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2122594070P
Content-Type: text/plain; charset=us-ascii

On Sat, 19 Apr 2003 22:56:21 +0200, Helge Hafting said:

> There are commercially available programs that guarantees to
> wipe your drive clean - including hidden areas and remapped
> sectors.  You should then be able to send drives
> back for warranty replacement.

These don't address the problem - if the drive won't go "ready" because
of a blown server platter, your data won't get overwritten but it's still
readable (a number of companies make good money at this).

In general, if the disk is dead enough that you're looking at replacement,
you'll probably not be totally pleased with the results of those programs..

> There are also bulk erasers that reset every bit magnetically,
> but those will probably void the warranty too.  (You'll
> need a low-level reformat to recreate sector addresses on the
> suddenly blank surface.)

Note that this only works well for single-platter disks - the field
you need to get the *inner* surfaces of the platters, especially for
a 5 or 6 platter disk, is quite astounding....

We ran into this issue recently on one of our Sun servers - Sun *does*
have a program to deal with this, but (a) you have to specifically ask
them and (b) it's additional charge.

--==_Exmh_2122594070P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+obxycC3lWbTT17ARAlq6AKCgB8OC+/oTiOOODNONGWPbb4amdgCfQ1eP
NvEvjtUFv5F+Jo2/dg0mcV8=
=ZzQf
-----END PGP SIGNATURE-----

--==_Exmh_2122594070P--

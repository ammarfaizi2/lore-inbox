Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUAPUhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUAPUhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:37:51 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62336 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265844AbUAPUho (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:37:44 -0500
Message-Id: <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL 
In-Reply-To: Your message of "Fri, 16 Jan 2004 15:22:39 EST."
             <4008480F.70206@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <4008480F.70206@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_810811409P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Jan 2004 15:37:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_810811409P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Jan 2004 15:22:39 EST, Timothy Miller <miller@techsource.com>  said:

> Think about it!  If we had a filesystem that actually DID this, and it 
> was in the Linux kernel, it would spread far and wide.  It's bound to 
> happen that someone will identify a collision.  We then report that to 
> the committee offering the reward and then donate it to OSDL to help 
> Linux development.

Actually, it's *not* "bound to happen".  Figure out the number of blocks you'd
need to have even a 1% chance of a birthday collision in a 2**128 space.

And you'd need that many disk blocks on *a single system*.

Then figure out the chances of a collision on a small machine that only has 20
or 30 terabytes (yes, in this case terabytes is small).

The whole reason "use MD5 as a check for identical blocks" is useful is because
the chances of *that* going wrong are vanishingly small compared to the chances
that a memory stick will throw an undetected multiple-bit error, or that a RAID
controller will write blocks to the wrong disks, or any number of other things
that *do* happen in real life, but rarely enough that we don't bother writing
code to defend against them.



--==_Exmh_810811409P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFACEuVcC3lWbTT17ARAqm1AJ0Z0Fr2V0HWsyxXs1qh6eihHEPwhgCZAfcR
yDYTPMokPWtz/jtHwXlGo3U=
=xZ1x
-----END PGP SIGNATURE-----

--==_Exmh_810811409P--

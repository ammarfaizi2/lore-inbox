Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266653AbUBLWuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUBLWuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:50:23 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48353 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266653AbUBLWuU (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:50:20 -0500
Message-Id: <200402122250.i1CMoCJ7025967@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
In-Reply-To: Your message of "Thu, 12 Feb 2004 23:29:11 +0100."
             <200402122329.11182.robin.rosenberg.lists@dewire.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040209115852.GB877@schottelius.org> <200402122039.19143.robin.rosenberg.lists@dewire.com> <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk>
            <200402122329.11182.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_826973564P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 17:50:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_826973564P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Feb 2004 23:29:11 +0100, Robin Rosenberg said:

> a space in a filename.  This shouldn't be any worse than that. The space
> issue is really serious (but I don't think that can be fixed other than teaching
> people to program properly, and possibly improving bash's knowledge of the 
> difference between a space and argument separator).

Other than allocating a key and bytecode for non-breaking-white-space as a
separator (Hmm.. allocate 'left-windows' purely for ironic value? ;), how do
you propose to actually improve it's knowledge of the distinction?  The basic
problem is that we're overloading x'20' as both space and separator, and then
end up disambiguating based on context and syntax.  And quite frankly, I don't
see much hope for improving things as long as x'20' is overloaded.

Could go the VMS command/this/that/the/other/thing route, I guess?  :)


--==_Exmh_826973564P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALAMkcC3lWbTT17ARAnUHAJ99oKPqAhQf+JIAGHHixTe5WfLJRACggA/m
rJGnF8GFnq0uKVWF82MD0CU=
=ViQG
-----END PGP SIGNATURE-----

--==_Exmh_826973564P--

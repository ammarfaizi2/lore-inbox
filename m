Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272976AbTHMN1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273027AbTHMN1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:27:17 -0400
Received: from h80ad26b0.async.vt.edu ([128.173.38.176]:56192 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272976AbTHMN1N (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:27:13 -0400
Message-Id: <200308131326.h7DDQqqe008997@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org, linux-fs@vger.kernel.org
Subject: Re: 2.6.0test2mm4 reiser bug? Buffer I/O error on device hda2, logica... 
In-Reply-To: Your message of "Wed, 13 Aug 2003 11:55:25 +0300."
             <Pine.LNX.4.56.0308131151070.11964@hosting.rdsbv.ro> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.56.0308131151070.11964@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1998553459P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Aug 2003 09:26:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1998553459P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Aug 2003 11:55:25 +0300, Catalin BOIE said:
> I have some problems with 2.6.0test2mm4.
> I get the error from subject when I try to read a file on the disk.
> In userspace I get EIO.
> 
> With 2.6.0test3mm1 the problem seems to disapear!

There was one nasty bug with readahead fixed in test2-mm5.  I
believe (but could be wrong) that it only affected filesystems that
were on "logical" partitions (software RAID, LVM/DM, loopback, etc)
under memory pressure..

> Do I have to worry?

If that's your problem, you don't have to worry once you get to test2-mm5 or
later with a clean fsck of the disk.  If it's something else, you still need to worry ;)


--==_Exmh_1998553459P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OjybcC3lWbTT17ARAthkAKCKssiIkAB4SYMxlWnfPyGmn0sdOwCg0eYo
17/tjAXouJlWQKlR/acMmiM=
=0C4F
-----END PGP SIGNATURE-----

--==_Exmh_1998553459P--

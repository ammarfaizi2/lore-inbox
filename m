Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUAHOyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUAHOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:54:40 -0500
Received: from h80ad37a4.dhcp.vt.edu ([128.173.55.164]:21120 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264479AbUAHOyi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:54:38 -0500
Message-Id: <200401081454.i08EsZBu005830@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jens Axboe <axboe@suse.de>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: blockfile access patterns logging 
In-Reply-To: Your message of "Thu, 08 Jan 2004 15:39:08 +0100."
             <20040108143908.GA8688@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040108120008.GA7415@outpost.ds9a.nl> <200401081430.i08EUVfx005021@turing-police.cc.vt.edu>
            <20040108143908.GA8688@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1359036619P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jan 2004 09:54:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1359036619P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Jan 2004 15:39:08 +0100, Jens Axboe said:

> For laptops, it's often most interesting to find out _what_ process
> dirtied what data (which in turn caused bdflush to sync it), or what
> process keeps doing small reads. And block_dump does exactly that (it
> was invented for exactly that purpose :)

I submit that "what process ID did it" is even more remote from the disk
than "what inode" ;)

> I don't think you understand what Bert is looking for. He explicitly
> mentions that the machine is very idle, so he's probably looking for
> culprits that spin up the drive occasionally.

Oh, I understand very well.. Been there myself.  I'd just forgotten that
the laptop patch provided the process-ID information. ;)


--==_Exmh_-1359036619P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE//W8rcC3lWbTT17ARAmu5AJ9ZoZCj755T/j0YA/nidjzQjvf6MgCgmF4M
KfhlQNSWsuYlVYuguDHPw+4=
=nqr4
-----END PGP SIGNATURE-----

--==_Exmh_-1359036619P--

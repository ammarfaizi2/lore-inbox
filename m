Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUEKPyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUEKPyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbUEKPyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:54:32 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:1190 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264808AbUEKPyV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:54:21 -0400
Message-Id: <200405111554.i4BFs4hU015073@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic allocation of swap disk space 
In-Reply-To: Your message of "Tue, 11 May 2004 16:52:15 BST."
             <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <fa.n6pggn5.84en31@ifi.uio.no> <40A0EFC0.1040609@sgi.com>
            <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-202761952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 11:54:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-202761952P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 16:52:15 BST, John Bradford said:

> Imagine a system with limited physical RAM, and limited swap space, running a
> process which causes a lot of filesystem activity on the same physical disk
> as is being used for swap.  If the total RAM, both physical and swap is almost
> completely full, increasing the swap space may allow some data from physical
> RAM to be swapped out, in favour of caching filesystem data from the disk.

Possible, but wouldn't that imply that the value of /proc/sys/vm/swappiness
is very mis-set and causing a too-high estimate of the working set size?


--==_Exmh_-202761952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoPcccC3lWbTT17ARAnDEAKDpnZcoovTfE30sqm9/Rl41bBofJgCfYi+x
kJgqMBRpu0PMggHlRzHQKm4=
=Xcuq
-----END PGP SIGNATURE-----

--==_Exmh_-202761952P--

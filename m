Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272844AbTHSQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272816AbTHSQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:57:38 -0400
Received: from h80ad2795.async.vt.edu ([128.173.39.149]:38279 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S276360AbTHSQaS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:30:18 -0400
Message-Id: <200308191630.h7JGUEVq004537@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: jjluza <jjluza@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with test3-mm3 and nvidia drivers 
In-Reply-To: Your message of "Tue, 19 Aug 2003 15:36:53 +0200."
             <200308191536.53124.jjluza@yahoo.fr> 
From: Valdis.Kletnieks@vt.edu
References: <200308191536.53124.jjluza@yahoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_593121676P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 12:30:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_593121676P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Aug 2003 15:36:53 +0200, jjluza <jjluza@yahoo.fr>  said:
> I try to compile nvidia drivers (closed sources) with test3-mm3 but it doesn't 
> work anymore.

Nevermind, known problem..  That will teach me not to check first. ;)

> I will warn the nvidia patch maintainer (minion.de) about it.

They know, there's a patch for -test3-bk5 should Just Work for -mm3.

Linux 2.5 (2.5.75, 2.6.0-test2) updated 08/18/2003

This patch is the 1.0-4496 equivalent of the 1.0-4363 patch, the same
installation instructions and comments apply. If you experience problems with
this patch, please let me know.

In Linux 2.6.0-test3-bk5, PCI names related data structures were changed again,
you will need to apply the incremental patch below to make the driver build on
this kernel. The patch is trivial, if you are using another driver release, you
shouldn't have trouble porting the change. Download:

NVIDIA_kernel-1.0-4496-2.5.diff
NVIDIA_kernel-1.0-4496-2.6-bk5.diff


--==_Exmh_593121676P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QlCVcC3lWbTT17ARArcRAKD9/iSkGTe7KIA1LMXMZLXoot1vvgCeLtm0
uUgpmSCqJw6O55DEKhDsy6o=
=PVal
-----END PGP SIGNATURE-----

--==_Exmh_593121676P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTEFDzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEFDzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:55:33 -0400
Received: from h80ad263c.async.vt.edu ([128.173.38.60]:51584 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262312AbTEFDzc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:55:32 -0400
Message-Id: <200305060407.h4647vMF002448@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Michael Swift <mikesw@cs.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buggy drivers/modules needed 
In-Reply-To: Your message of "Mon, 05 May 2003 20:36:32 PDT."
             <2B0E86920B2B9C43A043DA80E447FCBC7BB895@exchsrv1.cseresearch.cs.washington.edu> 
From: Valdis.Kletnieks@vt.edu
References: <2B0E86920B2B9C43A043DA80E447FCBC7BB895@exchsrv1.cseresearch.cs.washington.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1185001688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 May 2003 00:07:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1185001688P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 May 2003 20:36:32 PDT, Michael Swift <mikesw@cs.washington.edu>  said:

> I'm working on a Linux patch to prevent buggy modules/drivers from causing
> the kernel to crash. Instead, the kernel detects a crash in the driver, and
> trans parently restarts the module. Currently this patch supports network
> interface card drivers, sound drivers, and file systems.

What are you planning to do about protecting a buggy module/driver from causing
a crash by stomping on somebody *elses* memory and corrupting some unrelated
data structure?

--==_Exmh_-1185001688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+tzUccC3lWbTT17ARAvtMAJ0UCx3eCtm87Bl4SoHeCPaSJsxiIgCg6atW
nWXAlSjgmr69P85OasHqu8U=
=pcDd
-----END PGP SIGNATURE-----

--==_Exmh_-1185001688P--

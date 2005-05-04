Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVEDTMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVEDTMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVEDTMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:12:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:25103 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261388AbVEDTMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:12:08 -0400
Message-Id: <200505041911.j44JBhda022528@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: A patch for the file kernel/fork.c 
In-Reply-To: Your message of "Wed, 04 May 2005 15:26:44 -0300."
             <427913E4.3070908@cachola.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <4278E03A.1000605@cachola.com.br> <20050504175457.GA31789@taniwha.stupidest.org>
            <427913E4.3070908@cachola.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115233903_4721P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 May 2005 15:11:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115233903_4721P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 May 2005 15:26:44 -0300, =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= said:

> In a preemptible kernel with the serport module and a serial port try to 
> run the following program:

> and kill it.
> In my case it will hang the computer. I think this is a problem with the 
> serport module. With this patch, the serial mouse stop working, but the 
> computer don't hang.

The fact that the mouse stops working is indicative that this patch doesn't
actually fix the problem, it's just pushing it around in the kernel - sooner
or later something *else* is going to go pear-shaped on the null *mm.  The right
fix is to figure out why mm is bogus and fix that issue.

--==_Exmh_1115233903_4721P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCeR5vcC3lWbTT17ARAuRfAJ93dCobGEdoRCQIPmrPCRJec9G1CwCfSmXt
W5Xn6I8/udXBFSxJwFM4VqQ=
=4ppE
-----END PGP SIGNATURE-----

--==_Exmh_1115233903_4721P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVJETnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVJETnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVJETnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:43:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10408 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030346AbVJETm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:42:59 -0400
Message-Id: <200510051942.j95Jgt4d022559@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: umesh chandak <chandak_pict@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Waring in kernel 2.6.10 
In-Reply-To: Your message of "Wed, 05 Oct 2005 12:27:54 PDT."
             <20051005192754.11115.qmail@web35905.mail.mud.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20051005192754.11115.qmail@web35905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128541375_3015P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Oct 2005 15:42:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128541375_3015P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Oct 2005 12:27:54 PDT, umesh chandak said:

Not actually a kernel problem, most likely...

>            I have compiled a kernel 2.6.10 on FC3 it
> gives me the warning like this 

> Warning: unable to open an initial console.

It can't find /dev/console.

Most likely, you're running with either no initrd or a busticated one.

FC3 assumes you're using an initrd, and that the initrd has a number of
files already defined in a small /dev that's used to get things started,
and /dev/console is one of those things.



--==_Exmh_1128541375_3015P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDRCy/cC3lWbTT17ARApvCAJ91AwdjVoXG4BGb56UacdXMqkrLswCgnqnu
bD9YX3W0j2LyG5uxN0RG1AA=
=tvw0
-----END PGP SIGNATURE-----

--==_Exmh_1128541375_3015P--

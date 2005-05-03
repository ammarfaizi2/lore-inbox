Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVECWca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVECWca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVECWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:32:29 -0400
Received: from h80ad252c.async.vt.edu ([128.173.37.44]:41996 "EHLO
	h80ad252c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261875AbVECWbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:31:44 -0400
Message-Id: <200505032231.j43MVfMC028606@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: segin <segin11@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error in include/linux/mod_devicetable.h 
In-Reply-To: Your message of "Tue, 03 May 2005 14:27:15 PDT."
             <20050503212715.94232.qmail@web21127.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050503212715.94232.qmail@web21127.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115159500_3418P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 May 2005 18:31:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115159500_3418P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 May 2005 14:27:15 PDT, segin said:

> The error occurs when compiling a program (dosemu) that uses the include file stated above.
> I won't hog your mailboxes with useless infomation.

> /usr/include/linux/mod_devicetable.h:18: error: parse error before "__u32"

Don't use kernel headers from userspace.  This includes the ever-popular but
always-broken idea of symlinking the kernel headers into /usr/include, which
you seem to have done.

> Jeez... Is it just me or is it that most people today are too fucking retarded to use a computer?

Do you really want me to answer that?

--==_Exmh_1115159500_3418P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCd/vLcC3lWbTT17ARAg/IAKCpvGHLU41TNwXmxtO6uCsKvPcQwQCgmH8k
zLWqaGFv4HuPNlqp5swEDrI=
=heDK
-----END PGP SIGNATURE-----

--==_Exmh_1115159500_3418P--

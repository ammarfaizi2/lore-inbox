Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTLAAuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTLAAuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:50:35 -0500
Received: from h80ad2462.async.vt.edu ([128.173.36.98]:49576 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262356AbTLAAud (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:50:33 -0500
Message-Id: <200312010050.hB10oR02008420@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug with extraversion in kernel-2.4.23 
In-Reply-To: Your message of "Mon, 01 Dec 2003 01:16:02 +0100."
             <20031201011602.A12652@ss1000.ms.mff.cuni.cz> 
From: Valdis.Kletnieks@vt.edu
References: <1070229674.3fca68aaea488@webmail.tuxfamily.org>
            <20031201011602.A12652@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1954617174P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Nov 2003 19:50:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1954617174P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 Dec 2003 01:16:02 +0100, Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>  said:
> > The extraversion variable of the Makefile is very badly interpreted.
> > When the kernel is installed, I have 2 directory of modules :
> > /lib/modules/2.4.23
> > /lib/modules/2.4.23-fnux (my extraversion is -fnux)
> 
> No way. The directory without -fnux is probably just a leftover from previous
> make modules_install. When you run 2.4.23-fnux, you won't need it.

On the other hand, you probably want to keep the 2.4.23(no-ext) directory
around as well, so you can boot a 2.4.23 kernel to clean up after a broken
build of a 2.4.23-fnux won't boot.

There's a reason why my /lib/modules has 6 subdirectories - I have 6
bootable kernels sitting around, Just In Case (well... OK. 2 spares would
probably be enough, but it's easier to do a "which -mm did the problem start?"
regression if you have the most recent few handy to try.. ;)

--==_Exmh_-1954617174P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ypBRcC3lWbTT17ARAubmAKCINqsWUXgAkmkk9xhycX944fGb9ACg/afu
Gu0fftss6YurPJcpKzCQVWg=
=kfKO
-----END PGP SIGNATURE-----

--==_Exmh_-1954617174P--

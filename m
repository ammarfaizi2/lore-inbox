Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTKXSXD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKXSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:22:45 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52867 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263786AbTKXSWj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:22:39 -0500
Message-Id: <200311241822.hAOIMGKL013070@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems 
In-Reply-To: Your message of "Mon, 24 Nov 2003 13:10:46 EST."
             <Pine.LNX.4.53.0311241307560.18675@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <20031124183757.A2507@ss1000.ms.mff.cuni.cz>
            <Pine.LNX.4.53.0311241307560.18675@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1358408728P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Nov 2003 13:22:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1358408728P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Nov 2003 13:10:46 EST, "Richard B. Johnson" said:

> # chmod 4755 xxx
> # su johnson
> $ cp /tmp/xxx .
> $ ls -la xxx
> -rwxr-xr-x   1 rjohnson guru         4887 Nov 24 12:57 xxx
     ^  Hmm.. this sucker is mode 755, not 4755...

> This clearly shows that once the file exists in a non-root
> directory, it will not function as setuid root.

No, what it shows is that once you *copy* the file to another file,
and the second file isn't set-UID, it won't run as set-UID anymore.

--==_Exmh_1358408728P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/wkxYcC3lWbTT17ARAgP8AKDAc/BOpBfDk3obOipn0Vemc7DoAwCfTkKB
PwJxH7bQjfb8cszE3WjQi0k=
=ovek
-----END PGP SIGNATURE-----

--==_Exmh_1358408728P--

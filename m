Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVBHDP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVBHDP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 22:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVBHDP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 22:15:56 -0500
Received: from h80ad2550.async.vt.edu ([128.173.37.80]:47377 "EHLO
	h80ad2550.async.vt.edu") by vger.kernel.org with ESMTP
	id S261451AbVBHDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 22:15:50 -0500
Message-Id: <200502080315.j183FUnv004232@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chris Wright <chrisw@osdl.org>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8) 
In-Reply-To: Your message of "Mon, 07 Feb 2005 18:20:36 PST."
             <20050207182035.D469@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net> <200502072241.j17MfTfP027969@turing-police.cc.vt.edu> <cu95po$3ch$1@abraham.cs.berkeley.edu> <200502080210.j182Aioh007619@turing-police.cc.vt.edu>
            <20050207182035.D469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107832529_3225P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 22:15:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107832529_3225P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 18:20:36 PST, Chris Wright said:
> * Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> > open("/tmp/sh-thd-1107848098", O_WRONLY|O_CREAT|O_TRUNC|O_EXCL|O_LARGEFILE,
 0600) = 3
> 
> O_EXCL
> 
> > Wow - if my /tmp was on the same partition, and I'd hard-linked that
> > file to /etc/passwd, it would be toast now if root had run it.
> 
> So, in fact, it wouldn't ;-)

Well.. Yeah.  bash gets it right, a lot of programs botch it. ;)

--==_Exmh_1107832529_3225P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCCC7RcC3lWbTT17ARAub+AJwNFwr0lq5b6km5a4zyir/gBM1VwACgwfuD
GvDq5wryg9rrC5cSrSF8lAQ=
=REdj
-----END PGP SIGNATURE-----

--==_Exmh_1107832529_3225P--

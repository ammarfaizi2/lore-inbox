Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTJURm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbTJURmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:42:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9344 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263207AbTJURmx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:42:53 -0400
Message-Id: <200310211742.h9LHglK3004891@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1 
In-Reply-To: Your message of "Tue, 21 Oct 2003 15:43:44 -0000."
             <bn3k7g$h24$1@gatekeeper.tmr.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031020020558.16d2a776.akpm@osdl.org>
            <bn3k7g$h24$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-735151391P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Oct 2003 13:42:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-735151391P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Oct 2003 15:43:44 -0000, davidsen@tmr.com (bill davidsen)  said:
>
> | +devfs-initrd-fix.patch
> | 
> |  Fix initrd when devfs is in use
> 
> I casually followed the thread on this, is this a band-aid or a magic
> spell of healing? Do you consider this a "real fix" for the various
> problems people reported?

Well, the options were to (a) move it to anywhere except under /dev and (b) to
make it cooperate with devfs.  (a) seemed more reasonable when Linus is asking
for a stability freeze... 

A *real* fix, which would require re-architecting devfs/udev/whatever and the
whole initrd/initramfs and probably other stuff, should be looked at for 2.7.


--==_Exmh_-735151391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lXAXcC3lWbTT17ARAveuAKCC7t0gJm3aUZMHPJo3iUBOksboIgCfdVvs
O3oVSJL0eZtUqm3cRspOyVQ=
=idRw
-----END PGP SIGNATURE-----

--==_Exmh_-735151391P--

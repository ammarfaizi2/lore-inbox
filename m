Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTDNVuA (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTDNVsa (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:48:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:46977 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263982AbTDNVsH (for <RFC822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:48:07 -0400
Message-Id: <200304142159.h3ELxrIO017333@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect' document. 
In-Reply-To: Your message of "Mon, 14 Apr 2003 23:48:07 +0200."
             <20030414214807.GB993@mars.ravnborg.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030414193138.GA24870@suse.de>
            <20030414214807.GB993@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1861524832P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Apr 2003 17:59:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1861524832P
Content-Type: text/plain; charset=us-ascii

On Mon, 14 Apr 2003 23:48:07 +0200, Sam Ravnborg <sam@ravnborg.org>  said:

> Can I safely delete /sbin/update from my initscripts then?

Only if you're REALLY REALLY sure that you're never going to boot a
kernel that doesn't have the pdflush daemon functionality in it.  This
might be an issue if you still need to boot a 2.2 kernel (I think 2.4
has had the pdflush stuff in it since 2.4.mumble).  I'm sure somebody
can give a definitive answer when pdflush became mainline kernel....

--==_Exmh_-1861524832P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+my9ZcC3lWbTT17ARAgvRAJ9yLSYNt/F9O/cmbyiMEtH3bWhXJACgqYvK
SxASMvtx2wWOTEjy1arKuEY=
=tddk
-----END PGP SIGNATURE-----

--==_Exmh_-1861524832P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVB1Uqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVB1Uqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVB1Uqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:46:44 -0500
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:8455 "EHLO
	h80ad25cd.async.vt.edu") by vger.kernel.org with ESMTP
	id S261731AbVB1Uqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:46:38 -0500
Message-Id: <200502282046.j1SKkGV7009849@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 - pcmcia weirdness/breakage 
In-Reply-To: Your message of "Mon, 28 Feb 2005 21:22:26 +0100."
             <20050228202226.GA16284@isilmar.linta.de> 
From: Valdis.Kletnieks@vt.edu
References: <200502281948.j1SJmKdV006528@turing-police.cc.vt.edu>
            <20050228202226.GA16284@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109623576_3594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Feb 2005 15:46:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109623576_3594P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Feb 2005 21:22:26 +0100, Dominik Brodowski said:
> On Mon, Feb 28, 2005 at 02:48:20PM -0500, Valdis.Kletnieks@vt.edu wrote:

> > A full -rc4-mm1 fails, *as does* a -rc4-mm1 with all the following patches -R'ed:
...
> > broken-out/pcmcia-bridge-resource-management-fix.patch
....
> > So the breakage is in *some other* -rc4-mm1 patch.  Any hints to speed up
> > the binary search?
> 
> Most likely it's
> pcmcia-bridge-resource-management-fix.patch

I'd believe you, except that patch has already been -R'ed and I'm still seeing
the problem.  That's why I'm mystified - I backed out all the obvious culprits
already, and the problem's still there...

--==_Exmh_1109623576_3594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCI4MYcC3lWbTT17ARAgZVAKD62O7QLTaReNbfbmy5pfG6nRXbagCgkgCr
bdPt4H2o78G1GeBMJtZQus8=
=07R+
-----END PGP SIGNATURE-----

--==_Exmh_1109623576_3594P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUFBSr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUFBSr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUFBSpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:45:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49857 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263823AbUFBSpC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:45:02 -0400
Message-Id: <200406021844.i52IivRG012724@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Greg KH <greg@kroah.com>
Cc: Manu Abraham <manu@kromtek.com>, linux-kernel@vger.kernel.org
Subject: Re: Minor numbers under 2.6 
In-Reply-To: Your message of "Wed, 02 Jun 2004 07:49:31 PDT."
             <20040602144931.GA25424@kroah.com> 
From: Valdis.Kletnieks@vt.edu
References: <200406021519.32128.manu@kromtek.com>
            <20040602144931.GA25424@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1379265926P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 14:44:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1379265926P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jun 2004 07:49:31 PDT, Greg KH said:

> Just make sure you have a up to date glibc.

We don't currently require any specific glibc level:

% grep -i glibc /usr/src/linux-2.6.6-mm3/Documentation/Changes 
%

Hmm... Should we make a note of the glibc level required to make this work?
Possibly as a "If you want to use more than 256 minors" optional?

--==_Exmh_1379265926P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAviApcC3lWbTT17ARAkhvAJ9o40kUA6da6weG3PRTGGhgTag+egCfYgcT
fOZH5Z89yg8R8VQXUrWVfPs=
=Xs1x
-----END PGP SIGNATURE-----

--==_Exmh_1379265926P--

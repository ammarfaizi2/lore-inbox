Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWGDOsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWGDOsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 10:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWGDOso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 10:48:44 -0400
Received: from pool-72-66-194-43.ronkva.east.verizon.net ([72.66.194.43]:36549
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932263AbWGDOso (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 10:48:44 -0400
Message-Id: <200607041448.k64EmTPM023918@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Bruce Ferrell <bferrell@baywinds.org>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
In-Reply-To: Your message of "Mon, 03 Jul 2006 15:04:54 PDT."
             <44A99486.6050307@baywinds.org>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
            <44A99486.6050307@baywinds.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152024509_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 10:48:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152024509_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 15:04:54 PDT, Bruce Ferrell said:
> Valdis.Kletnieks@vt.edu wrote:

> > There's other issues as well.  Why do people run 'tripwire' on boxes that
> > have RAID on them?
> 
> Because they're looking for malicous changes

Close, but no cigar.

I've had tripwire detect *accidental* changes as well (including borked
patchsets that replaced unrelated files).  The reason they run tripwire
as well as RAID is to detect changes that are visible only with the assistance
of information from the filesystem.  

--==_Exmh_1152024509_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqn+9cC3lWbTT17ARAuErAKDMTOuWZubtBPxa1l1WCLcOP9KpDQCfW806
iBYzbhvuSEfN+4jWZXX9za4=
=3SyS
-----END PGP SIGNATURE-----

--==_Exmh_1152024509_4949P--

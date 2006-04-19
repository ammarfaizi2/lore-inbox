Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDSHF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDSHF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWDSHF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:05:26 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19631 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750706AbWDSHFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:05:25 -0400
Message-Id: <200604190704.k3J74gLS010530@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Kurt Garloff <garloff@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Gerrit Huizenga <gh@us.ibm.com>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-Reply-To: Your message of "Tue, 18 Apr 2006 23:38:33 +0200."
             <20060418213833.GC5741@tpkurt.garloff.de> 
From: Valdis.Kletnieks@vt.edu
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com> <20060418115819.GB8591@infradead.org>
            <20060418213833.GC5741@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145430282_10003P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 03:04:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145430282_10003P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Apr 2006 23:38:33 +0200, Kurt Garloff said:
> AppArmor is easy. Everyone with a little background in Un*x can
> understand what it does and how it needs to be configured.
> Eventually, most sysadmins of the world can configure it correctly
> and thus make their systems more secure.

Having spent a quarter century in which cleaning up after other sysadmins
has played a major role, I think you're vastly overstating the average clue level
out there.

Most of the readers of this list can (hopefully) snarf a linux-2.foo.tar.bz2
and end up with a bootable kernel on their own.  The *actual* average sysadmin
out there has trouble getting something like 'up2date' (or the Ubuntu equivalent)
to update an already vendor-compiled kernel.

Experience has shown that if you make the sysadmin configure it using anything
more than 1 or 2 very broad knobs ("fairly secure, very secure, tinfoil-hat secure"),
it *very* quickly becomes a way for them to create security holes in their system,
and doesn't add any actual security.

And the instant you abstract it all behind a point-and-drool GUI with a choice
of 3 buttons to click, it doesn't matter anymore, because the distro vendor
will be doing all the heavy lifting.

--==_Exmh_1145430282_10003P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEReEKcC3lWbTT17ARAtSLAKCUwsh8vNRAqoohjl/mlFmF713E0QCbBjuE
QYisA3Yljp1NebKCFk78Lcw=
=fLhx
-----END PGP SIGNATURE-----

--==_Exmh_1145430282_10003P--

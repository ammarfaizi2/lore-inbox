Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWDYRNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWDYRNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWDYRNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:13:18 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9367 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932271AbWDYRNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:13:17 -0400
Message-Id: <200604251712.k3PHCbnj002821@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Joshua Brindle <method@gentoo.org>
Cc: Andi Kleen <ak@suse.de>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview 
In-Reply-To: Your message of "Mon, 24 Apr 2006 11:16:25 EDT."
             <444CEBC9.5030802@gentoo.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org> <200604241526.03127.ak@suse.de> <444CD507.70004@gentoo.org>
            <444CEBC9.5030802@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145985157_2618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 13:12:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145985157_2618P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Apr 2006 11:16:25 EDT, Joshua Brindle said:

> To make this much more real, the /usr/sbin/named policy that ships with 
> apparmor has the following line:
> /** r,
> Thats right, named can read any file on the system, I suppose this is 
> because the policy relies on named being chrooted. So if for any reason 
> named doesn't chroot its been granted read access on the entire 
> filesystem.

Somebody *please* tell me I hallucinated the posting that said AppArmor
restricts the use of chroot by confined processes...

In any case, the incredibly brittle behavior of this policy in the face
of chroot() failure (from the people who should *know* how to write AppArmor
policy, no less) is just proof of why making it simple for non-experts to
write policy is a Bad Idea....

--==_Exmh_1145985157_2618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETliFcC3lWbTT17ARAihyAKDH6eqGOKlq4+7FXhsjPpAxIOcaBQCfeg2j
viocBdJF+98FVY3auK3KkS8=
=lnOa
-----END PGP SIGNATURE-----

--==_Exmh_1145985157_2618P--

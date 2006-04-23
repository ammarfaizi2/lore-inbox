Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWDWJsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWDWJsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 05:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDWJsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 05:48:05 -0400
Received: from h80ad249d.async.vt.edu ([128.173.36.157]:31910 "EHLO
	h80ad249d.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751215AbWDWJsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 05:48:03 -0400
Message-Id: <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ken Brush <kbrush@gmail.com>
Cc: Crispin Cowan <crispin@novell.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Sat, 22 Apr 2006 13:52:57 PDT."
             <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <200604021240.21290.edwin@gurde.com> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu> <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
            <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145785534_3800P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Apr 2006 05:45:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145785534_3800P
Content-Type: text/plain; charset=us-ascii

On Sat, 22 Apr 2006 13:52:57 PDT, Ken Brush said:
> That sysadmins are not sophisticated enough to properly configure the
> MAC systems AppArmor and SELinux effectively?

We know they're usually not.  There are a *few* that have a clue, but most
don't.  And as the Linux market grows, we're going to have more and more Linux
sysadmins with less than a year's experience...

>                                                Or that people who use
> AppArmor are not likely to put careful thought into the policies that
> they use?

They're not likely to put careful thought into it, *AND* that saying things
like "AppArmor is so *simple* to configure" only makes things worse - this
encourages unqualified people to create broken policy configurations.

I have no problem with "handles a lot of the grunt work so an
expert can write policy quicker" - there's people working on policy
editors for SELinux that address this as well.  It is however a dis-service
to conflate this with "makes it easy for non-experts to write policy".  Yes,
they may be able to "write policy" easily.  The question is whether it
enables then to "write *correct* policy" (easily, or at all).....

--==_Exmh_1145785534_3800P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFES0y+cC3lWbTT17ARAtDjAJ9yWJxQxMcYbQzngQtvGEMulKqmxQCg5FHs
JDCxq47vxF9isLmetZlpal8=
=gjQE
-----END PGP SIGNATURE-----

--==_Exmh_1145785534_3800P--

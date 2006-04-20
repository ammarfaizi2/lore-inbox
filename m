Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWDTP3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWDTP3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWDTP3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:29:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:46501 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751016AbWDTP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:29:08 -0400
Message-Id: <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Crispin Cowan <crispin@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Wed, 19 Apr 2006 17:19:04 PDT."
             <4446D378.8050406@novell.com> 
From: Valdis.Kletnieks@vt.edu
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
            <4446D378.8050406@novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145546843_2712P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Apr 2006 11:27:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145546843_2712P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Apr 2006 17:19:04 PDT, Crispin Cowan said:
> Valdis.Kletnieks@vt.edu wrote:
> > In other words, it's quite possible to accidentally introduce a vulnerability
> > that wasn't exploitable before, by artificially restricting the privs in a way
> > the designer didn't expect.  So this is really just handing the sysadmin
> > a loaded gun and waiting.
> >   
> While that is true of the voluntary model of acquiring and dropping
> privs, it is not true of AppArmor containment, which will just not give
> you the priv if it is not in your policy.

The threat model is that you can take a buggy application, and constrain its
access to priv A in a way that causes a code failure that allows you to abuse
an unconstrained priv B.

--==_Exmh_1145546843_2712P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFER6hbcC3lWbTT17ARAuaqAJ9Yp4RxKmsl3NlmC2V/UFmnl9WEDgCg7/Q1
Ny62I7S048tVDaj7bCnlUwM=
=50Or
-----END PGP SIGNATURE-----

--==_Exmh_1145546843_2712P--

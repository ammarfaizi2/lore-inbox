Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUIQQfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUIQQfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUIQQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:30:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48080 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269026AbUIQQaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:30:24 -0400
Message-Id: <200409171630.i8HGUF92007463@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: journal aborted, system read-only 
In-Reply-To: Your message of "Thu, 16 Sep 2004 09:36:01 EDT."
             <200409160936.01539.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <200409121128.39947.gene.heskett@verizon.net> <1095088378.2765.18.camel@sisko.scot.redhat.com> <200409160634.i8G6YhOR008893@turing-police.cc.vt.edu>
            <200409160936.01539.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-835704746P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Sep 2004 12:30:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-835704746P
Content-Type: text/plain; charset=us-ascii

On Thu, 16 Sep 2004 09:36:01 EDT, Gene Heskett said:

> >This happened about 4 minutes into a 'tar cf - | (cd && tar xf -)'
> > pipeline to clone a work copy of the -rc1-mm5 source tree (it got
> > about 408M through the 543M before it blew up)....
> 
> Humm, it happened to me while amdump was running, and amdump uses tar.
> My tar version is 1.13-25.

I don't think "tar" is anything more than an enabler here - it's just that on
my laptop it's one of the more abusive things I can do to the file system (especially
when source and dest directories are on the same file system).  I've had the problem
pop up while reading down my e-mail, which is another "lots of little files" scenario
(500+ lines of procmailrc, passing stuff to/from spamassassin, and storing in the
MH "one message per file" format)....

I'm about to start building -rc2-mm1 - I'm probably going to liberally sprinkle some
strategic printk's so we have a chance of flushing out why it's failing...

--==_Exmh_-835704746P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBSxEWcC3lWbTT17ARAlM4AKC8Vrh96Md9qfl4zVpqLwRX79e/gQCfR8cG
oCp02V72OQia3m7PvNcmZdY=
=uxUi
-----END PGP SIGNATURE-----

--==_Exmh_-835704746P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTJKQsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJKQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:48:39 -0400
Received: from h80ad24a2.async.vt.edu ([128.173.36.162]:56719 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263142AbTJKQsi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:48:38 -0400
Message-Id: <200310111648.h9BGmZ6s026348@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: asdfd esadd <retu834@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model 
In-Reply-To: Your message of "Sat, 11 Oct 2003 09:06:21 PDT."
             <20031011160621.22378.qmail@web13006.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031011160621.22378.qmail@web13006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-381369844P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Oct 2003 12:48:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-381369844P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Oct 2003 09:06:21 PDT, you said:
> 
> the other OS has an at this stage highly consistent
> object model user along the lines of COM+ from the
> kernel up encompassing a single event, thread etc.
> model. Things are quite consistently wrapped, user
> mode exposed if needed etc. If people were to fully
> draw on it and the simpler .net BCL and not ride win32
> that would (will be) a killer.  

If all your friends jumped off a cliff, would you do it too?

I submit to you that the reason The Other OS needs the concept of a object
model from the kernel through to user space is because the architects had a
very fuzzy concept of "boundary".  Yes, you need stuff like that if your GUI
and your IIS (yes, really, Win2003 apparently has IIS on the kernel side of the
boundary now).  If you have a syscall interface, the kernel is free to
implement read() in any way it wants, and the userspace calling read() is able
to use it for pretty much anything.

Ask yourself:  (a) Could I implement .NET in userspace using the supplied syscalls?
(b) If .NET was implemented and enforced kernel-side, could I implement CORBA?

Remember - it's quite possible that the user wants some OTHER GUI, or some
OTHER thread model, or some OTHER.....  We're not the operating system run by
jackboots.


--==_Exmh_-381369844P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/iDRicC3lWbTT17ARAuimAJ9fybP+eq2KAwkZ4W/Zjzf70LC+RwCg5POa
HzuzXTFPJmbm+imlPQCbKrs=
=sw4R
-----END PGP SIGNATURE-----

--==_Exmh_-381369844P--

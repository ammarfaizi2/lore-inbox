Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUDAS7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUDAS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:59:30 -0500
Received: from supermail.mweb.co.za ([196.2.53.171]:48902 "EHLO
	supermail.mweb.co.za") by vger.kernel.org with ESMTP
	id S263059AbUDAS70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:59:26 -0500
Date: Thu, 1 Apr 2004 21:00:04 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Message-Id: <20040401210004.6f30c8e2@bongani>
In-Reply-To: <200404011221.21476@WOLK>
References: <20040331030921.GA2143@dualathlon.random>
	<20040331211620.19a8f725@bongani>
	<200404011157.33051@WOLK>
	<200404011221.21476@WOLK>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__1_Apr_2004_21_00_16_+0200_gjLvmy1texCIoVbN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__1_Apr_2004_21_00_16_+0200_gjLvmy1texCIoVbN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 01 Apr 2004 12:21:21 +0200
Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:

> On Thursday 01 April 2004 11:57, Marc-Christian Petersen wrote:
> 
> Hi again,
> 
> > > I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of my
> > > memory was gone, but my swap was never touched. I managed to get only the
> > > output of SysRq-M before it hard-locked. For some reason it doesn't swap.
> > > I'll try to reproduce.
> 
> > hmm, I am running 2.6.5-rc3-aa1 stuff ontop of 2.6.5-rc3-mm3. It works very
> > well. What is the value of /proc/sys/vm/swappiness?
> 
> I really manage it to forget something again and again ;(

8<

> cat /proc/sys/vm/swappiness 
> 48
> 
> ciao, Marc

My swappiness is 60, and 2.6.5-rc2-aa4 was running fine for a while until that occured. 
Andrea sent me a python script that showed that it does swap. I'll try to reproduce it still.

--Signature=_Thu__1_Apr_2004_21_00_16_+0200_gjLvmy1texCIoVbN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbGbM+pvEqv8+FEMRAnGwAJ9uPZ3d48OQGZaCJDkq1recyTR/4QCfdRAv
69YQCuhgp3zBPPx6bOp2Pzk=
=mUqw
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Apr_2004_21_00_16_+0200_gjLvmy1texCIoVbN--

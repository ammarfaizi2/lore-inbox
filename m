Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTDTSwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTDTSwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:52:25 -0400
Received: from h80ad2676.async.vt.edu ([128.173.38.118]:55173 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263675AbTDTSwX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:52:23 -0400
Message-Id: <200304201904.h3KJ4IZJ015475@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept? 
In-Reply-To: Your message of "Sun, 20 Apr 2003 12:51:54 +0200."
             <20030420105154.GA16451@hh.idb.hist.no> 
From: Valdis.Kletnieks@vt.edu
References: <20030419180421.0f59e75b.skraw@ithnet.com> <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com> <20030419184120.GH669@gallifrey> <20030419205621.GA15577@hh.idb.hist.no> <200304192115.h3JLFVuL018983@turing-police.cc.vt.edu>
            <20030420105154.GA16451@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1133931394P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Apr 2003 15:04:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1133931394P
Content-Type: text/plain; charset=us-ascii

On Sun, 20 Apr 2003 12:51:54 +0200, Helge Hafting said:

> > These don't address the problem - if the drive won't go "ready" because
> > of a blown server platter, your data won't get overwritten but it's still
> > readable (a number of companies make good money at this).
> > 
> I see.  Your data is so special that you expect people to pay for
> reconstruction hoping to find something that pays for all
> that trouble and more.

No, I don't consider my data that special - I just say "screw it" and
go looking for the backups.  However, my point is that it's not THAT
hard to salvage data off drives - it's easy enough that companies are
making a living doing it.

The question is regarding sites that are paranoid about shipping out
their data when such recovery is possible.

> Why would it be hard to reach the inner surfaces - the disks
> are not superconducting so the outer ones do not shield the
> inner ones from a strong magnetic field.  You should be fine
> as long as the field extend far enough to get the entire
> drive.  A high-frequency device might have trouble,
> but you don't need that - even a static field will do.

I didn't say it was impossible - I said you had to use a degausser that
was up to the task.  A degausser that is rated to bulk-erase tape media
is probably *NOT* sufficiently strong to do a multi-platter disk.  Most
tapes need 350 Oe or so to bulk, while disks are in the 1500 Oe range.

And you need a really big-ass magnet to make a 1500 Oe field big enough to
cover an entire disk (especially if it's an older disk of the 5.25 or
even larger variety - older IBM mainframe disks were up to 14" platters).

The Canadian government seems to agree - they recommend either getting the
degaussing wand between the platters (page 10) or using a cavity degausser
(page 12).  Note that they do *not* certify cavity degaussers for disk drives
over 3 1/2" with a coercivity over 1100Oe.

http://collection.nlc-bnc.ca/100/200/301/ cse-cst/cse_app-ef/itspl-02.pdf 



--==_Exmh_1133931394P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+ou8xcC3lWbTT17ARAt2FAJ9LuNY5iN33MCg3LT5Srla1C87ZaACg6z2E
efU1fB8ouZ5G/yGbokh1bAM=
=34uA
-----END PGP SIGNATURE-----

--==_Exmh_1133931394P--

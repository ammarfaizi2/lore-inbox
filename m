Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTAXSwp>; Fri, 24 Jan 2003 13:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTAXSwp>; Fri, 24 Jan 2003 13:52:45 -0500
Received: from h80ad25e3.async.vt.edu ([128.173.37.227]:16265 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261463AbTAXSwo>; Fri, 24 Jan 2003 13:52:44 -0500
Message-Id: <200301241901.h0OJ1j0V005436@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider) 
In-Reply-To: Your message of "Fri, 24 Jan 2003 08:52:46 PST."
             <20030124165246.59003.qmail@web80311.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030124165246.59003.qmail@web80311.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1050296320P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Jan 2003 14:01:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1050296320P
Content-Type: text/plain; charset=us-ascii

On Fri, 24 Jan 2003 08:52:46 PST, Kevin Lawton said:

> About 99% of the work of a full x86 VM is on handling less
> than 1% of the cases.  So the new plex86 angle is, forget doing
> all the fancy work for 1%.  If you're running a VM friendly OS
> (like Linux with my small patches), you end up with a potentially high
> performance and Open Source VM, with very little work.

One of the first implementations of VM was by IBM, called CP/67.  It
eventually evolved into VM/370 and its follow-ons.

The initial design reason for CP/67 was to allow 2 or more MVS development
teams to share a system for testing, so the other team could keep working
while the first team debugged a system crash with tools better than the
lights-n-switches at the console.

It turns out that the 99% of the work to cover the 1% of the cases is really
important.  The usual reason for doing VM is to isolate images from each other
- and if you don't cover that last 1%, a programming error in one of the images
can nuke your supervisor code into oblivion.  It may be a "VM friendly OS like
Linux", but it can still oops in strange ways. For starters, what happens
if you run a Linux *without* your patches under plex86? ;)

Now if you think about it, and not covering the 1% case is deemed acceptable,
that's OK too.  But it's something that needs to be considered.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1050296320P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+MY2YcC3lWbTT17ARAnTGAKC3fxsQt+TWZConyhLqwd1WdHm9IgCeN7b/
zkMzEbRXMrIlf+DtsY/AcBs=
=+l31
-----END PGP SIGNATURE-----

--==_Exmh_-1050296320P--

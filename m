Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUAYAHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUAYAHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:07:22 -0500
Received: from h80ad2638.async.vt.edu ([128.173.38.56]:2692 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263510AbUAYAFw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:05:52 -0500
Message-Id: <200401250004.i0P04mx8005321@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>, Felix von Leitner <felix-kernel@fefe.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording 
In-Reply-To: Your message of "Sat, 24 Jan 2004 15:53:44 PST."
             <Pine.LNX.4.44.0401241550350.14163-100000@bigblue.dev.mdolabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0401241550350.14163-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1768925803P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Jan 2004 19:04:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1768925803P
Content-Type: text/plain; charset=us-ascii

On Sat, 24 Jan 2004 15:53:44 PST, Davide Libenzi said:

> > Anyway, the code's ancient but might provide some ideas:
> > 
> > 	http://www.zip.com.au/~akpm/linux/fboot.tar.gz
> 
> Warning. I don't know if they do have a patent for this, but MS does this 
> starting from XP (look inside %WINDIR%\PreFetch). It is both boot and app 
> based.

Hmm.. prior art time. ;)

IBM's OS/VS1 and MVS operating systems had the 'link pack area', where
frequently loaded modules were loaded at system startup.  And there were
numerous 3rd party optimizers that would analyze the LOAD SVC patterns on your
system and produce a list of which modules should be pre-loaded in order to get
the most bang for the buck (even a *large* 370/168 or 303x processor might be
able to spare a megabyte tops, so optimizing it was important, and sites would
spend $5K on software that would optimize the memory usage and save them a
memory upgrade at $40K a meg...

This was mid-70s, so definitely pre-XP.


--==_Exmh_-1768925803P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAEwgfcC3lWbTT17ARAsOqAJoDO4L3j+95l3xwSab9TOvEtAsb+gCglm+i
htSx2h/iFx4V9yrFzVT6ni0=
=RRft
-----END PGP SIGNATURE-----

--==_Exmh_-1768925803P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTBTLRI>; Thu, 20 Feb 2003 06:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTBTLRH>; Thu, 20 Feb 2003 06:17:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23558 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265154AbTBTLRG>; Thu, 20 Feb 2003 06:17:06 -0500
Date: Thu, 20 Feb 2003 06:23:46 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
In-Reply-To: <20030220062323.GX351@lug-owl.de>
Message-ID: <Pine.LNX.3.96.1030220060638.14551A-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY=z1Pli9ypV4pBfZC4
Content-ID: <Pine.LNX.3.96.1030220060638.14551B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--z1Pli9ypV4pBfZC4
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030220060638.14551C@gatekeeper.tmr.com>

On Thu, 20 Feb 2003, Jan-Benedict Glaw wrote:

> On Wed, 2003-02-19 15:39:44 -0500, Bill Davidsen <davidsen@tmr.com>

> > If you have simple needs that's fine. I build for multiple groups of
> > machines, and with a working mkinitrd I can just build a file for the boot
> > controller on each type of machine, and only build a single kernel which
> > will run anywhere with the proper initrd file.
> 
> I do it the other way around - I've collected a number of .config files
> (one for each machine) which includes everything the machine needs to
> *boot*.

But... if you have it in .config, then you have to rebuild the kernel each
time. Maybe on an Alpha that doesn't matter, on anything I use a kernel
build takes minutes and an initrd create take seconds.

>          Any additional features (LVM/DM, filesystems, iptables, ...)
> ships as modules. Things which require a distinct order are placed into
> /etc/modules (Debian's list of modules which need to be loaded in given
> order), all the rest is done via alias/install lines in
> modules.conf/modprobe.conf.
> 
> This is, you do keep a machine's local config in its initrd, I do keep
> it on the machine itself.

Okay, now I see what you are doing, I guess you just have enough system
power to invest the time and disk space in building a kernel for each
config. When there was a working mkinitrd I was happily able to use fewer
of my resources to generate boot setups for all my systems, at least of a
given arch.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--z1Pli9ypV4pBfZC4
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030220060638.14551D@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+VHRaHb1edYOZ4bsRApXeAJ9Yuzuc3zjKVHgQv5hYX0iiyzMJKgCePQFh
GubR3CE852uWIayoMSc63hY=
=pwbf
-----END PGP SIGNATURE-----

--z1Pli9ypV4pBfZC4--

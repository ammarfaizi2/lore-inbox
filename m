Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTBSUdH>; Wed, 19 Feb 2003 15:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBSUdH>; Wed, 19 Feb 2003 15:33:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23813 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267291AbTBSUdF>; Wed, 19 Feb 2003 15:33:05 -0500
Date: Wed, 19 Feb 2003 15:39:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
In-Reply-To: <20030219195543.GW351@lug-owl.de>
Message-ID: <Pine.LNX.3.96.1030219153452.11297B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY=4n3ekn15JG+S0x0c
Content-ID: <Pine.LNX.3.96.1030219153452.11297C@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--4n3ekn15JG+S0x0c
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030219153452.11297D@gatekeeper.tmr.com>

On Wed, 19 Feb 2003, Jan-Benedict Glaw wrote:

> On Wed, 2003-02-19 13:00:39 -0500, Bill Davidsen <davidsen@tmr.com>

> > Be aware that for Redhat and SuSE distributions (and mandrake??) "make
> > install" will fail because mkinitrd doesn't know about the new modules
> > format.
> > 
> > So you can give up using modules for anything you want to use to boot,
> 
> Which is what I prefer - I personally don't like initrd and I don't use
> it.

If you have simple needs that's fine. I build for multiple groups of
machines, and with a working mkinitrd I can just build a file for the boot
controller on each type of machine, and only build a single kernel which
will run anywhere with the proper initrd file.

using initrd files also allows easy control of the order in which SCSI
controllers are loaded, which prevents drives from changing names.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--4n3ekn15JG+S0x0c--

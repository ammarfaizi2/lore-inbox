Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSGOAlZ>; Sun, 14 Jul 2002 20:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSGOAlY>; Sun, 14 Jul 2002 20:41:24 -0400
Received: from lsanca2-ar27-4-3-064-252.lsanca2.dsl-verizon.net ([4.3.64.252]:1920
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S317264AbSGOAlX>; Sun, 14 Jul 2002 20:41:23 -0400
Date: Sun, 14 Jul 2002 17:43:51 -0700 (PDT)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Heinz Diehl <hd@cavy.de>, <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       <andre@linux-ide.org>
Subject: Re: Linux 2.5.25-dj2
In-Reply-To: <Pine.LNX.4.44.0207141716590.3174-100000@barbarella.hawaga.org.uk>
Message-ID: <Pine.LNX.4.44.0207141740460.2865-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 14 Jul 2002, Ben Clifford wrote:

> >>EIP; d08ff420 <[ide-cd]ll_10byte_cmd_build+0/d0>   <=====

ide-cd.o is loaded at boot, and I have been manually unloading it before 
attempting to modprobe ide-scsi24.

So I rm'd the ide-cd.o from my modules directory as an easy way to stop it 
ever being loaded and I can modprobe ide-scsi24 without the oops 
happening.

I am attempting to rerecord a CD-RW at the moment to see if it works
properly - it is in the blanking stage at the moment and appears to be 
ok...

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9MhrKsYXoezDwaVARAtQDAJ0RCg3YDcWVtWICxscA18KaWXr3ogCcDDpe
cbnDZdbOtWSgIdVtrnBFj1U=
=KK1q
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTHWSwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTHWSwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 14:52:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:56830 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263634AbTHWSwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 14:52:51 -0400
From: Patrick Dreker <patrick@dreker.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: nforce2 lockups
Date: Sat, 23 Aug 2003 20:52:40 +0200
User-Agent: KMail/1.5.9
Cc: kenton.groombridge@us.army.mil, linux-kernel@vger.kernel.org
References: <200308231550.h7NFoZtr022365@harpo.it.uu.se>
In-Reply-To: <200308231550.h7NFoZtr022365@harpo.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200308232052.46684.patrick@dreker.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 23. August 2003 17:50 schrieb Mikael Pettersson <mikpe@csd.uu.se> 
zum Thema Re: nforce2 lockups:
> On Sat, 23 Aug 2003 14:48:06 +0200, Patrick Dreker <patrick@dreker.de> 
> > >Am Samstag, 23. August 2003 14:20 schrieb Mikael Pettersson 
> >zum Thema Re: nforce2 lockups:
> >> On Sat, 23 Aug 2003 10:41:46 +0900, kenton.groombridge@us.army.mil
> >> "noapic" (note: no "l") might very well fix your board, but that's
> >see above. noapic had no effect on the freezes. On boot it still said
> > "found and enabling local APIC"
> Of course it did. "noapic" and BIOS APIC mode relate to the I/O-APIC,
> not the local APIC.
Well it's my first board which has an APIC, so I'm still learning how that all 
belongs together...

> My guess is that your BIOS or graphics card can't handle the local
> APIC, presumably due to a crap SMM# handler or you using APM's
> CPU_IDLE or DISPLAY_BLANK options.
Someone else already hinted, that it might be the BIOS/SMM problem. APM is 
completely disabled
> Kernel 2.6.0-test4 supports "nolapic", so that's an option too.
> I'll send that patch to Marcelo for 2.4.23-pre so it should be
> in 2.4 eventually.
I'll try that, and Asus have updated their BIOS for the Board, so I'll give 
that a shot, too.
- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/R7f+cERm2vzC96cRAvwXAJ9M49KQUWCI37LJXAUamJiM0628lwCfXPjO
eapurx/Indgk60tVCJ96ztc=
=bebd
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266406AbUALVTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUALVRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:17:00 -0500
Received: from quake.mweb.co.za ([196.2.45.85]:53943 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S266262AbUALVN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:13:56 -0500
Date: Mon, 12 Jan 2004 22:25:08 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: detlef.grittner@t-online.de (Detlef Grittner)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: modprobe behaves strange
Message-Id: <20040112222508.04054b59.bonganilinux@mweb.co.za>
In-Reply-To: <4002FF88.3000303@t-online.de>
References: <4002FF88.3000303@t-online.de>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__12_Jan_2004_22_25_08_+0200_Ctis7UPc=LNqX2h6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__12_Jan_2004_22_25_08_+0200_Ctis7UPc=LNqX2h6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2004 21:11:52 +0100
detlef.grittner@t-online.de (Detlef Grittner) wrote:

> Hello,
> 
> I'm using the x86_64 architecture branch and have simply copied the 
> kernel into my configuration of a 2.4.21 kernel.
> 
> I have the following lines in /etc/modules.conf:
> 
> alias eth0 r8169
> 
> alias snd-card-0 snd-via82xx
> 
> With the 2.4.21 kernel everything worked fine, with the 2.6.1 kernel I 
> get the following behavior:
> 
> modprobe eth0
> (no error, but r8169 not loaded)
> 
> modprobe r8169
> (module r8169 is loaded and works)
> 
> modprobe snd-card-0
> (FATAL: Modul snd_card_0 not found)
> 
> modprobe snd-via82xx
> (module snd-via82xx is loaded and works)
> 
> 
> I'm not really a kernel expert and so I have to ask:
> Am I right, that this could be a problem of the kernel?
> Is this the wildcard problem that was fixed in mm1?
> Should I try mm1 or where should I begin to search for the problem?
> 
> Detlef
> 

you have to install module-init-tools it has a modprobe that works with 2.6 modules. See Document/Changes under your linux 2.6 sorce

--Signature=_Mon__12_Jan_2004_22_25_08_+0200_Ctis7UPc=LNqX2h6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAwKr+pvEqv8+FEMRAjAqAJ9VRyCtwsSqcFWHU3MW8VfKI+gd4QCggAzW
ffzTulW4LigUYsBY9nGRLWM=
=QjsU
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Jan_2004_22_25_08_+0200_Ctis7UPc=LNqX2h6--

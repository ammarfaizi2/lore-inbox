Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTDMDKQ (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTDMDKQ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:10:16 -0400
Received: from h80ad2778.async.vt.edu ([128.173.39.120]:49026 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263128AbTDMDKP (for <RFC822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 23:10:15 -0400
Message-Id: <200304130317.h3D3HprZ021939@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm2 
In-Reply-To: Your message of "Sun, 13 Apr 2003 03:55:29 +0200."
             <1050198928.597.6.camel@teapot.felipe-alfaro.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030412180852.77b6c5e8.akpm@digeo.com>
            <1050198928.597.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1394136846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Apr 2003 23:17:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1394136846P
Content-Type: text/plain; charset=us-ascii

On Sun, 13 Apr 2003 03:55:29 +0200, Felipe Alfaro Solana said:

> Any patches for CardBus/PCMCIA support? It's broken for me since
> 2.5.66-mm2 (it works with 2.5.66-mm1) probably due to PCI changes or the
> new PCMCIA state machine: if I boot my machine with my 3Com CardBus NIC
> plugged in, the kernel deadlocks while checking the sockets, but it
> works when booting with the card unplugged, and then plugging it back
> once the system is stable (for example, init 1).

Also seeing this with a Xircom card under vanilla 2.5.67.

lspci reports this card as:

03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)

Russel King posted an analysis back on April 1, which indicated he knew
about the problem, understood it, and was working on it.


--==_Exmh_-1394136846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+mNbVcC3lWbTT17ARAusmAKD8gvTxjgQBWOiK8m2vFeNgq1WyQACeP9FN
TT0oNQcSp3IMtjZKUvMUZ54=
=HZZf
-----END PGP SIGNATURE-----

--==_Exmh_-1394136846P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUHPJOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUHPJOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHPJOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:14:36 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:23950 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S267480AbUHPJOe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:14:34 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
Date: Mon, 16 Aug 2004 10:13:13 +0100
User-Agent: KMail/1.6.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040813140229.4F48B2FC2C@illicom.com> <1092435364.24960.35.camel@localhost.localdomain>
In-Reply-To: <1092435364.24960.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408161013.13829.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.11; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Is your raid controller 64bit capable ? If you can I'd also go to a 2.6
> kernel for anything > 1Gb, and definitely > 4Gb of RAM. The differences
> are astounding although if your PCI I/O hardware cant do 64bit access
> your box will suck whatever kernel 8)

Would this also mean that if I stick a 64bit SATA raid card (a 3Ware 8506-4LP 
in this case) into a 32bit pci slot, then I/O is always going to suck badly?

... cos I do, and I/O sucks :)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIHqpBn4EFUVUIO0RAr4HAKCXDnm8YM2f7jY9awix/0KVyoUvYwCeJdmU
+gatlxR+IHurHnTPXDDITqk=
=2Rrq
-----END PGP SIGNATURE-----

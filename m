Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUB1SwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUB1SwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:52:12 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:31100 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261902AbUB1Svv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:51:51 -0500
Message-ID: <4040E335.5090401@helsinki.fi>
Date: Sat, 28 Feb 2004 20:51:33 +0200
From: Kliment Yanev <Kliment.Yanev@helsinki.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
References: <40408852.8040608@helsinki.fi> <20040228104105.5a699d32.rddunlap@osdl.org>
In-Reply-To: <20040228104105.5a699d32.rddunlap@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

|
| What is this driver for?  Where can I find it?

The nokia c110 is a prism2-based wireless lan card that does not
work with the normal prism driver because it has a different controller
and a big pile of extra unneeded and unsupported stuff like a smartcard
reader...

Available here:

http://www.nokia.com/nokia/0,5184,2718,00.html

|
| All those errors should go away if you build the module correctly.
| Please read Documentation/kbuild/m*.txt or see LWN.net article
| on building modules:
|   http://lwn.net/Articles/21823/

Thanks...I'll try that...however I just realized I don't even have a
linux driver for the pci to pcmcia cradle that it's supposed to work
with (i82365-compatible PCI card support was dropped from the kernel
driver and pcmcia-cs driver won't build if there is pcmcia support in
the kernel and the whole package won't compile without pcmcia support in
the kernel...)
Therefore, I won't be able to test this until I get a laptop in use in
two weeks time...

|
| --
| ~Randy

Kliment
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAQOM1rPQTyNB9u9YRAt3CAJ0fbmpZkjZzrqszDokBiHzLjKjSdwCgmRax
Dwb+j0DcIDSYuWyRqdxdZ4Y=
=NMOm
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVBQNWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVBQNWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVBQNWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:22:15 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:17830
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S262150AbVBQNWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:22:09 -0500
Message-ID: <42149A1D.4020901@winischhofer.net>
Date: Thu, 17 Feb 2005 14:20:29 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bruno.virlet@gmail.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AMD 64 and Kernel AGPart support
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I wondered about this a couple of minutes ago, too. I have a SiS760 and
can't enable AGP support either.

What host bridge does your system have? If it's anything but a 760, the
agpgart code for sis needs to be patched by adding the proper PCI ID.
(All this apart from the !X86_64 in the Kconfig file.)

I am running 32bit only at the moment (waiting for a new harddisk to
install, the 32bit system is only for some initial testing), but does
AGP compile and initialize correctly if you remove the !X86_64 in
drivers/char/agp/Kconfig at the AGP_SIS entry?

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCFJodzydIRAktyUcRAoIlAJ9jHr0rvTzx4Ea5eLWZsmhj3h9iBgCgvt6r
aSKGQteRZWegCJq3i3Lmf+c=
=y/95
-----END PGP SIGNATURE-----

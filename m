Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULDW4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULDW4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULDW4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:56:08 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:27839 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261188AbULDWzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:55:53 -0500
Message-ID: <41B24076.7090804@g-house.de>
Date: Sat, 04 Dec 2004 23:55:50 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: network console
References: <41A78D0A.5060308@pbl.ca> <41A7E8AD.9050405@g-house.de> <41AB31FD.2030501@pbl.ca>
In-Reply-To: <41AB31FD.2030501@pbl.ca>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Aleksandar Milivojevic schrieb:
> 
> Not exactly what I had in mind, but having kernel printk messages sent
> to remote host will be helpfull too.  What I had in mind was actually
> having two-way fully functional network console (something I could also
> use to log onto the machine, say if I screw up firewall settings and
> lock myself out).

that would require an additional and "secure-by-default" device, otherwise
your firewall would be superfluous.
- - serial console
- - setup just another ethX next to your other ethernetdevices and make it a
point-to-point connection to your machine. isdn/ppp dial-in with
authentication will also do here.

i hope i got your point....

- --
BOFH excuse #441:

Hash table has woodworm
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBskB1+A7rjkF8z0wRAhPhAKCtsfEDYemUeFpsWgalb1jCZfBvEwCgoHW0
BYGc4vk3xI3bVLnagmc1B7U=
=vvN3
-----END PGP SIGNATURE-----

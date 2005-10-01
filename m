Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVJAVkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVJAVkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVJAVkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:40:04 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:64645 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1750867AbVJAVkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:40:01 -0400
Message-ID: <433F0228.6000304@gorzow.mm.pl>
Date: Sat, 01 Oct 2005 23:39:52 +0200
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
User-Agent: Thunderbird 1.4 (X11/20050930)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.13-rc2+ - problem with DHCP
References: <433EBBEC.4050203@gorzow.mm.pl> <433ECE42.2070400@trash.net>
In-Reply-To: <433ECE42.2070400@trash.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patrick McHardy wrote:
|
| Are you sure? The patch was supposed to fix problems with DHCP clients
| using regular UDP sockets for sending DHCP requests. Which client are
| you using?
|

udhcpcd, version 0.9.9-pre (Gentoo ebuild
net-misc/udhcp-0.9.9_pre20041216-r1, no crazy optimisations, stock init
script, IP release disabled)

2.6.13, 2.6.14-rc1 (up to the patch) both work fine.
2.6.14-rc2 and 2.6.14-rc3 do not. (they can't discover IP address)
The window is between that commit and rc2.
(about 180 changesets)

I only suspect that patch, it could be something else but I highly doubt
it. I'll check the current kernel with the patch backed out when I have
to restart.

- --
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPwIolUMEU9HxC6IRAit8AJ0TXQv+BO3rn0L39JsCad7UqyUMRACeIf+U
cvzDCU1x9oTP2V4AjELJUvY=
=hp5I
-----END PGP SIGNATURE-----

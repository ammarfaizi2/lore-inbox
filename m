Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVB1O0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVB1O0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVB1OZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:25:31 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:55982 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261637AbVB1OXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:23:32 -0500
Message-ID: <42232965.9050909@g-house.de>
Date: Mon, 28 Feb 2005 15:23:33 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: unsupported PCI PM caps (again?)
References: <42226647.4040000@g-house.de> <20050228074005.GA2915@isilmar.linta.de>
In-Reply-To: <20050228074005.GA2915@isilmar.linta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dominik Brodowski wrote:
> As the "unsupported PCI PM cap regs version (1)" handling caused trouble on
> some devices, it got removed in 2.6.11-rc5.

hm, the only change in the changelog with "PCI_PM_CAP" is:

<daniel.ritz@gmx.ch>
	[PATCH] PCI: support PCI_PM_CAP version 1
	A check for the PM_CAP version was recently added but i breaks
        devices with version 1.  if they're in power-save mode they never
        get out of it.
	Change it to also support v1.

i guess i just have to try...

thanks,
Christian.
- --
BOFH excuse #270:

Someone has messed up the kernel pointers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCIyll+A7rjkF8z0wRAuehAJ94fyqYAjXLm3imHiYXTPzfbMBwoACgzwpp
JI7yznEVDwmOp11sB4Ez1Vc=
=epms
-----END PGP SIGNATURE-----

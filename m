Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbULJWSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbULJWSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbULJWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:16:43 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:62166 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261847AbULJWPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:15:02 -0500
Message-ID: <41BA1FE3.3020108@g-house.de>
Date: Fri, 10 Dec 2004 23:14:59 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: felix-linuxkernel@fefe.de
Subject: Re: ipv6 getting more and more broken
References: <20041209024649.GA26553@codeblau.de>
In-Reply-To: <20041209024649.GA26553@codeblau.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

felix-linuxkernel@fefe.de schrieb:
> ipv6 is broken for me with 2.6.9 (worked great with 2.6.7, less good but
> still workable with 2.6.8).  Here are the symptoms:

i *felt* something was wrong around 2.6.8.1 or 2.6.9 but i tried to blame
my (free) tunnel broker. having 2.6.10-BK for a while now, everything is
back to normal. link-local addresses assigned, radvd is working too.

> Also, I would like to have a way to do mss clamping for IPv6.  I am
> running a Linux based PPPoE router using 6to4, and would like to
> route IPv6 to the LAN behind it, but TCP connections keep getting stuck.

hm, no issues here. mss clamping is described very often, but i never
really needed it. my ipv6 clients are working fine ;)

Christian.
- --
BOFH excuse #221:

The mainframe needs to rest.  It's getting old, you know.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBuh/j+A7rjkF8z0wRAqTeAJ9+wV+hN7SQdqJvTqd5QVfs32SuDgCePh0e
ZGUUSKv1plfZg2TNvmihQPU=
=UpiK
-----END PGP SIGNATURE-----

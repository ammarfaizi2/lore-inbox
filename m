Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbUKIVbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUKIVbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUKIVbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:31:46 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:44931 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261695AbUKIVbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:31:39 -0500
Message-ID: <41913737.8080309@g-house.de>
Date: Tue, 09 Nov 2004 22:31:35 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] kobject: fix double kobject_put() in error path of kobject_add()
References: <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <20041109190420.GA2498@kroah.com> <20041109190809.GA2628@kroah.com>
In-Reply-To: <20041109190809.GA2628@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH schrieb:
> lately.  I'd appreciate it if you could test it out and let me know if
> it solves your problem, with CONFIG_EDD enabled, or if it doesn't help
> at all.

please ignore my first mail (the part about not being able to patch), it's
already in BK i can see now, sorry.

compiling now...

- --
BOFH excuse #22:

monitor resolution too high
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkTc3+A7rjkF8z0wRAl7LAJ9/mXV4/uFet5aqpJB/02+J/654bACbBz/k
Px9muqjJ+e7OiRPDHbmyS1s=
=Q+hA
-----END PGP SIGNATURE-----

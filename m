Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUKIWHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUKIWHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbUKIWHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:07:03 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:58755 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261723AbUKIWGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:06:44 -0500
Message-ID: <41913F6A.5010806@g-house.de>
Date: Tue, 09 Nov 2004 23:06:34 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Pekka Enberg <penberg@gmail.com>, Matt_Domsch@dell.com
Subject: Re: [PATCH] kobject: fix double kobject_put() in error path of kobject_add()
References: <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org> <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <20041109190420.GA2498@kroah.com> <Pine.LNX.4.58.0411091108470.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411091108470.2301@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

i'm sorry to say that it did not help:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1_edd__kobject_put.txt

i'll go on and try to exclude

ChangeSet@1.2000.5.108, 2004-10-20 08:36:22-07:00, Matt_Domsch@dell.com
	  [PATCH] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR

(or just test /pub/linux/kernel/v2.6/snapshots/old/patch-2.6.9-bk*.gz ...)

thanks,
Christian.
- --
BOFH excuse #200:

The monitor needs another box of pixels.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkT9q+A7rjkF8z0wRArHjAJ4qSyZf+ioC4VkvPxk2fCNWUrl18QCeLK85
8e2EyGuWgBviGETlV25t/XE=
=Qvnz
-----END PGP SIGNATURE-----

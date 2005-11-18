Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbVKRKVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbVKRKVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 05:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbVKRKVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 05:21:47 -0500
Received: from bigip-smtp1.dyxnet.com ([202.66.146.141]:52966 "EHLO
	bigip-smtp1.dyxnet.com") by vger.kernel.org with ESMTP
	id S1161000AbVKRKVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 05:21:46 -0500
Message-ID: <437DAB32.1010004@thizgroup.com>
Date: Fri, 18 Nov 2005 18:21:38 +0800
From: Zhang Le <robert@thizgroup.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051028)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jeff shia <tshxiayu@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: can we sleep at the bottom half environment?
References: <7cd5d4b40511171955y7787b880i53d89c35a0629b3d@mail.gmail.com>
In-Reply-To: <7cd5d4b40511171955y7787b880i53d89c35a0629b3d@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

jeff shia wrote:

| hello, can we sleep at the bottom half environment?such as in a
| softirq or a workqueue? why? Thank you!
|
| jeffshia
|
in workqueue,     ok
in softirq,             not ok
check Robert Love's "Linux Kernel Development".

- --
Zhang Le, Robert
Linux Engineer/Trainer

ThizLinux Laboratory Limited
Address: Unit 1004, 10/F, Tower B,
Hunghom Commercial Centre, 37 Ma Tau Wai Road,
To Kwa Wan, Kowloon, Hong Kong
Telephone: (852) 2735 2725
Mobile:(852) 9845 4336
Fax: (852) 2111 0702
URL: http://www.thizgroup.com
Public key: gpg --keyserver pgp.mit.edu --recv-keys 1E4E2973

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDfasxvFHICB5OKXMRAizUAKCCo4uCMzQRpgSnPFb4DFQKs/EkDACgkpOe
89sGCzsxu6AjHoUfyMeRooU=
=B36D
-----END PGP SIGNATURE-----


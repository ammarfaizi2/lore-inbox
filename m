Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbRAELja>; Fri, 5 Jan 2001 06:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRAELjU>; Fri, 5 Jan 2001 06:39:20 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:44306 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S131103AbRAELjN>;
	Fri, 5 Jan 2001 06:39:13 -0500
Date: Fri, 5 Jan 2001 12:38:33 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: Mike <mike@khi.sdnpk.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How can I create root disk in Redhat 6.0
In-Reply-To: <3A55AAF7.4F5EDFCD@khi.sdnpk.org>
Message-ID: <Pine.LNX.4.30.0101051236350.8608-100000@studpc91.thndorm.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike wrote:

> Hi !!
>
> When i boot linux from rescue disk, i get following message:
>
> VFS: Insert root floppy disk to be loaded in RAM disk and press ENTER
>
> Now how can i create a root disk... I am trying to boot Redhat 6.0
>
>
> Regards,
> Mike
>


man mkbootdisk

Basically you do
mkbootdisk version-number-of-your-kernel

Sometimes with the addition of --device /dev/fd0 as this:
mkbootdisk --device /dev/fd0 version-number-of-your-kernel

The kernel version you are running can be seen by doing:
uname -a




/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VbI8USLExYo23RsRAiW4AKCo7Bg+TpLth1a2OOWFV0VvWyClHwCfUp3f
HEnQVOnAJYu1N0D2ZWJBLsg=
=nYhZ
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

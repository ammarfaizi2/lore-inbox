Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUHaIr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUHaIr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUHaIr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:47:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:11928 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267518AbUHaIrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:47:40 -0400
X-Authenticated: #4512188
Message-ID: <41343B2A.80909@gmx.de>
Date: Tue, 31 Aug 2004 10:47:38 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de>
In-Reply-To: <41336824.1040206@gmx.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Prakash K. Cheemplavam wrote:
| John W. Linville wrote:
| | Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
| | supporting SMART w/ unmodified smartctl and smartd userland binaries.
~ > I just tried to give it a go with libata from 2.6.9-rc1. I had to fix
| one rejects but the patching seemed to go fine beside that. Nevertheless
| after a boot with patched libata I get:
|
| smartctl -a /dev/sda
[snip]

| Device does not support SMART

Just wanted

Just wanted to say that smartctl -a -d ata /dev/sda works, as John
Linville and now Bruce aLlen suggested to try.

Cheers,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBNDsqxU2n/+9+t5gRAinMAJ0W6sfKD4LV7uv6X9XUxWeng2dWjQCfVolo
CXg7ylDp8eb6SI+C4GZz/Bk=
=N/WZ
-----END PGP SIGNATURE-----

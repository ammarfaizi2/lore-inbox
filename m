Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUHaJCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUHaJCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUHaJCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:02:53 -0400
Received: from imap.gmx.net ([213.165.64.20]:45212 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266725AbUHaI7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:59:02 -0400
X-Authenticated: #4512188
Message-ID: <41343DD4.8000302@gmx.de>
Date: Tue, 31 Aug 2004 10:59:00 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de> <41343B2A.80909@gmx.de> <41343C66.3080804@pobox.com>
In-Reply-To: <41343C66.3080804@pobox.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
| Prakash K. Cheemplavam wrote:
|> Just wanted to say that smartctl -a -d ata /dev/sda works, as John
|> Linville and now Bruce aLlen suggested to try.
|
| As I noted in another email, be careful...  that patch bypasses the SCSI
| command synchronization, so you could potentially send a SMART command
| to the hardware while another command is still in progress.

Yup, I read your warning, so I won't run a background monitor. In fact
jusr gave it a quick try and saw all is fine and then I am not going to
touch it for now. ;-)

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBND3UxU2n/+9+t5gRAl9qAKDzA+TNzFDAwpV+JSSHbrLf8EVZFQCg85Ad
b8mJa7ZBgt13V/sT2MRVeiI=
=haAQ
-----END PGP SIGNATURE-----

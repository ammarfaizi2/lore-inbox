Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUHJSZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUHJSZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHJSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:21:51 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:12363 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S267644AbUHJSUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:20:52 -0400
Message-ID: <41191149.8040203@suse.com>
Date: Tue, 10 Aug 2004 14:17:45 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File sizes > 2 GB on isofs?
References: <2rIVi-16U-45@gated-at.bofh.it> <m33c2u6fpm.fsf@averell.firstfloor.org>
In-Reply-To: <m33c2u6fpm.fsf@averell.firstfloor.org>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
| Jeff Mahoney <jeffm@suse.com> writes:
|
|
|>With DVDs becoming widely popular for personal data storage, this 2 GB
|>limit will probably become more and more of an issue.
|
|
| That is what UDF was for created, wasn't it?

That may well be true, but it's not a reason to not support the full
file size of iso9660 filesystems.

If my interpretation of the spec is correct, and I believe that it is,
then the max file size of an iso9660 filesystem is 4 GB. If it's not the
case, then mkisofs should be changed to not support such filesystems.
(Ignoring the recent fun with Joerg on LKML)

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGRFJLPWxlyuTD7IRAnN8AJ4vy4SM01CBmJuiUZ1nMh8iV5lLTwCdE8Wr
P8IAbt/HBzV/mhc/uDpeLnU=
=qqie
-----END PGP SIGNATURE-----

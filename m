Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272365AbTHEAPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272367AbTHEANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:13:13 -0400
Received: from smtp2.cwidc.net ([154.33.63.112]:44459 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S272365AbTHEAMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:12:51 -0400
Message-ID: <3F2EF677.1040308@tequila.co.jp>
Date: Tue, 05 Aug 2003 09:12:39 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 from csv fails to compile
References: <200308041313.52755.schwaigl@eunet.at> <20030804064358.GA854@suse.de>
In-Reply-To: <20030804064358.GA854@suse.de>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jens Axboe wrote:

> On Mon, Aug 04 2003, Clemens Schwaighofer wrote:
>
>>csv checkout from today (2003/08/04 ~11:00 JST)
>>
>>make -f scripts/Makefile.build obj=drivers/block
>>  gcc -Wp,-MD,drivers/block/.ll_rw_blk.o.d -Wall -Wstrict-prototypes
>>-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
>>-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default
>>-D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
>>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
- -march=k6
>>-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
>>-DKBUILD_BASENAME=ll_rw_blk -DKBUILD_MODNAME=ll_rw_blk -c -o
>>drivers/block/ll_rw_blk.o drivers/block/ll_rw_blk.c
>>drivers/block/ll_rw_blk.c: In function `blk_init_queue':
>>drivers/block/ll_rw_blk.c:1275: structure has no member named
`elevator_name'
>>make[2]: *** [drivers/block/ll_rw_blk.o] Error 1
>>make[1]: *** [drivers/block] Error 2
>>make: *** [drivers] Error 2
>>
>>the previews worked fine (last checkout I did around 5 days ago). in this
>>compile I added Raid system, Raiser, JFS) just for compile check ...
>
>
> your source is screwed, save you config and try again with another
> checkout.

I did, clean checkout (new directory), same error like before ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/LvZ2jBz/yQjBxz8RAiUAAJ0cbK8rsdlKlsemKy43TGW4hT0hhwCgxcTX
xy4iMY1Gu68uJLTG0L3OcRU=
=dat1
-----END PGP SIGNATURE-----


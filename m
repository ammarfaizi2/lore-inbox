Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315452AbSEUTOS>; Tue, 21 May 2002 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSEUTOR>; Tue, 21 May 2002 15:14:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315452AbSEUTOQ>;
	Tue, 21 May 2002 15:14:16 -0400
Message-ID: <3CEA9C42.B2871594@zip.com.au>
Date: Tue, 21 May 2002 12:13:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.17: ide & ext2 unresolved symbols in modules
In-Reply-To: <Pine.GSO.4.43.0205212200500.19324-100000@romulus.cs.ut.ee>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/drivers/ide/ide-disk.o
> depmod:         udma_tcq_enable

Not sure.

> depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/drivers/ide/ide-mod.o
> depmod:         blk_get_request

Needs exporting.  I'll let Jens do that...

> depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/fs/ext2/ext2.o
> depmod:         write_mapping_buffers

Needs to be exported.  I'll fix that.

Thanks.

-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131599AbQK2PJi>; Wed, 29 Nov 2000 10:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131610AbQK2PJ2>; Wed, 29 Nov 2000 10:09:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24850 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S131599AbQK2PJS>;
        Wed, 29 Nov 2000 10:09:18 -0500
Date: Wed, 29 Nov 2000 15:38:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 errors in test12-pre2 (freeing blocks not in datazone)
Message-ID: <20001129153851.D28399@suse.de>
In-Reply-To: <3A24EB83.5E842526@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A24EB83.5E842526@idb.hist.no>; from helgehaf@idb.hist.no on Wed, Nov 29, 2000 at 12:41:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2000, Helge Hafting wrote:
> I noticed something strange in my syslog today:
> 
> Nov 29 10:59:18 hh kernel: Trying to open MFT
> Nov 29 10:59:23 hh kernel: EXT2-fs error (device ide0(3,4)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 3301007960,
> count = 1

For corruption issues on IDE, you should switch to test12-pre3
immediately. If you can reproduce there, be sure to send a new
report.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

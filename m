Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135259AbQK0BUY>; Sun, 26 Nov 2000 20:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135262AbQK0BUP>; Sun, 26 Nov 2000 20:20:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47632 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S131266AbQK0BUC>;
        Sun, 26 Nov 2000 20:20:02 -0500
Date: Mon, 27 Nov 2000 01:50:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: ATA-4, ATA-5 TCQ status
Message-ID: <20001127015002.C31641@suse.de>
In-Reply-To: <20001127012812.A31641@suse.de> <Pine.LNX.4.30.0011270143050.21801-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0011270143050.21801-100000@iq.rulez.org>; from sape@iq.rulez.org on Mon, Nov 27, 2000 at 01:45:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27 2000, Sasi Peter wrote:
> > implementation listed in the specs Linux might as well not support it :)
> > It's simply not worth it.
> 
> But seriously, how come?
> 
> I thought they just somewhat like copied the SCSI implementation...

I wish they would have, and based it on atapi. But they didn't...
Basically it requires you to poll for completion of tags with
a service command.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

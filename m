Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131526AbQK2O6F>; Wed, 29 Nov 2000 09:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131540AbQK2O5z>; Wed, 29 Nov 2000 09:57:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21010 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S131526AbQK2O5i>;
        Wed, 29 Nov 2000 09:57:38 -0500
Date: Wed, 29 Nov 2000 15:26:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001129152652.B28399@suse.de>
In-Reply-To: <UTC200011291344.OAA150800.aeb@aak.cwi.nl> <Pine.LNX.4.21.0011291408470.974-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011291408470.974-100000@penguin.homenet>; from tigran@veritas.com on Wed, Nov 29, 2000 at 02:10:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2000, Tigran Aivazian wrote:
> On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:
> 
> > I just tried 2.4.0test12pre3, which has Jens' fix,
> > and no corruption to be seen. Will test a bit more,
> > but perhaps this did it.
> > 
> 
> I have also been testing very hard on the SMP (4xXeon/6G) machine with
> test12-pre3 and also cannot reproduce the problem. This is a SCSI-only
> machine and I don't know what Jens' fix is and whether it is applicable or
> not.

No, the fix could only really make a difference on IDE. So it can't
possibly account for all the corruption issues reported, but I'm hoping
at least some of them... The fix was posted in the other corruption
thread, and it's in test12-pre3 too.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

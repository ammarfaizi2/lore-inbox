Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUHIOrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUHIOrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUHIOpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:45:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4310 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266751AbUHIOoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:44:37 -0400
Date: Mon, 9 Aug 2004 16:44:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809144407.GV10418@suse.de>
References: <200408091438.i79EcT4t010630@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091438.i79EcT4t010630@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Joerg Schilling wrote:
> 
> >From: Jens Axboe <axboe@suse.de>
> >> If you were true and Linux would include _and_ use DMA abstraction, then
> >> we would have DMA with ide-scsi for all CD sector sizes.
> 
> >Just because we have an api for helping drivers map data for dma,
> >doesn't necessarily mean that they all use it. In 2.6.8 ide-scsi will
> 
> This is the first time that you mention it and you could have avoided a lot
> of mail if you did do eralier.

I believe your complaint was for 2.4, since it doesn't support SG_IO for
atapi devices. For 2.6 you are just wasting cycles using ide-scsi on
ATAPI burners.

> >use dma for all transfers. As I've already stated, I wont be fixing 2.4.
> >I've also included reasons for this. You seem to think that a 'DMA
> >abstraction layer' means there will be no hardware bugs, I only wish
> >that was so.
> 
> DMA abstraction does not fix HW bugs, it only allows you to behave the
> same for all "DMA users" for the same HW in the kernel.

If they all use the interface. Like with all interfaces, it takes time
before it's being used kernel-wide.

> >> YOu have only shown that you in many caes try to ignoore the truth ;-(
> 
> >I'm surprised an ego of your size can even be contained inside a
> >normally sized (I'm assuming, having never met you) human body. I guess
> >in your opinion, anything oozing from your brain is by definition the
> >truth? That's the only way that I can see your above sentence making
> >sense to you.
> 
> OK, as you just verified again that you are a frequent source of
> insulting people we should close this thread.
> 
> Let us start after you managed to regret and to learn to separate a
> technical discussion from personal unsulting.

I have lots of discussions on linux-kernel, and not all of them (very
few, in fact) end up in flames. You seem to end up in flames with
basically everyone. At least on linux-kernel, I believe my track record
is far better than yours. Your mails are often infuriating.

Since you do not listen to anything I say anyways and keep reiterating
the same comments again and again like a duracell bunny, it's hard to
have a technical discussion with you.

End of discussion from me. Before you claim I'm going away because I
have no arguments (that's rich, coming from you), I'm closing this
thread from my end since you bring nothing to the table except flame
bait and repeated empty arguments.

-- 
Jens Axboe


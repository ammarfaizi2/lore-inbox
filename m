Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311856AbSC1Gln>; Thu, 28 Mar 2002 01:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311875AbSC1Gle>; Thu, 28 Mar 2002 01:41:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63240 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311856AbSC1GlO>;
	Thu, 28 Mar 2002 01:41:14 -0500
Date: Thu, 28 Mar 2002 07:41:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Tobias Poschwatta <tp@fonz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG 2.5.7 in elevator.c:237
Message-ID: <20020328064109.GC31640@suse.de>
In-Reply-To: <20020328014159.GE3344@gusgus.local.fonz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28 2002, Tobias Poschwatta wrote:
> 
> Moin,
> 
> Linux 2.5.7
> BUG in elevator.c:237 (in interrupt handler)

Known, just remove the two lines triggering the bug in
drivers/block/elevator.c (236-237)

-- 
Jens Axboe


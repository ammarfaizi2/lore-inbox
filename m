Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280110AbRJaIxi>; Wed, 31 Oct 2001 03:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280113AbRJaIx2>; Wed, 31 Oct 2001 03:53:28 -0500
Received: from 87.ppp1-6.hob.worldonline.dk ([212.54.87.215]:30592 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280111AbRJaIxR>; Wed, 31 Oct 2001 03:53:17 -0500
Date: Wed, 31 Oct 2001 09:53:41 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes
Message-ID: <20011031095341.A5111@suse.de>
In-Reply-To: <20011031093353.F631@suse.de> <20011031.004311.85410732.davem@redhat.com> <20011031094650.H631@suse.de> <20011031.004919.61505836.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011031.004919.61505836.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 31 Oct 2001 09:46:50 +0100
>    
>    How is this different from my init_sg proposal? :-). The above looks
>    fine to me, I just think it is important that we take care of this.
>    
> My impression was that you wanted to do something like:
> 
> 	sgl = kmalloc();
> 	init_sg(sgl, nents);
> 
> 	for_each_ent() {
> 		... existing code ..
> 	}
> 
> If what you really meant was semantically identicaly to what I have
> proposed, I'm completely in agreement with it.  Please submit patches.

Yep, init_sg_entry is probably a better name... I'll hack up and submit
soonish.

-- 
Jens Axboe


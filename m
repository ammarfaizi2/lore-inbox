Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSFDMcP>; Tue, 4 Jun 2002 08:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSFDMcO>; Tue, 4 Jun 2002 08:32:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62917 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316598AbSFDMcN>;
	Tue, 4 Jun 2002 08:32:13 -0400
Date: Tue, 4 Jun 2002 14:32:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604123205.GD1105@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Jens Axboe wrote:
> plug? Wrt umem, it seems you could keep 'card' in the queuedata. Same
> for raid5 and conf.

Ok by actually looking at it, both card and conf are the queues
themselves. So I'd say your approach is indeed a bit overkill. I'll send
a patch in half an hour for you to review.

-- 
Jens Axboe


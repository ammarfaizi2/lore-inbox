Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312495AbSDSOR1>; Fri, 19 Apr 2002 10:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSDSOR0>; Fri, 19 Apr 2002 10:17:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33289 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312495AbSDSORZ>;
	Fri, 19 Apr 2002 10:17:25 -0400
Date: Fri, 19 Apr 2002 16:17:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ide updates
Message-ID: <20020419141723.GF813@suse.de>
In-Reply-To: <20020419133446.GA813@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19 2002, Jens Axboe wrote:
> # - (tcq) Arm handler before GET_STAT() service check in
> #   ide_dma_queued_start, WD seemed to trigger interrupt before that.
> #   Makes WD Expert drives work with tcq.

BTW, I really wanted to add (but forgot) that this is in large due to
Morten Helgesen being a very patient and persistent tester, trying small
tweaks here and there until the problems with the WD drive was clear.

More users like that, please :-)

-- 
Jens Axboe


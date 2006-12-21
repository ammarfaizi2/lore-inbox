Return-Path: <linux-kernel-owner+w=401wt.eu-S1423056AbWLUTd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056AbWLUTd7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423058AbWLUTd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:33:59 -0500
Received: from brick.kernel.dk ([62.242.22.158]:22174 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423056AbWLUTd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:33:58 -0500
Date: Thu, 21 Dec 2006 20:35:50 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: performance regression from block merge
Message-ID: <20061221193549.GF17199@kernel.dk>
References: <20061221112540.e4ba58bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221112540.e4ba58bc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21 2006, Andrew Morton wrote:
> 
> Jens, elapsed time for `mke2fs /dev/hdc5' with the anticipatory scheduler
> (at least) has gone from nine seconds to sixty as a result of the recent
> block merge.

About when? I'll double check and test here, I'm assuming you mean since
2.6.19?

> This is the enty enth time that block code has been slammed into mainline
> without having had exposure to -mm testers or even to me personally, and it
> it the second time (at least) that obvious regressions have occurred as a
> result.  I have a New Year's resolution for you ;)

I usually try and make sure that for-akpm is the same as for-linus, so
if you pull that then it'll go to -mm as well. Sometimes the window
isn't that big, I'll try and make sure it's seen at least one -mm before
going upstream.

-- 
Jens Axboe


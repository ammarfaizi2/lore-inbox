Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUJYI41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUJYI41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUJYI40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:56:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17852 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261696AbUJYI4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:56:18 -0400
Date: Mon, 25 Oct 2004 10:55:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1 oops
Message-ID: <20041025085542.GD8306@suse.de>
References: <200410231731.21778.l_allegrucci@yahoo.it> <200410241620.50438.l_allegrucci@yahoo.it> <200410242202.17981.l_allegrucci@yahoo.it> <200410251045.09370.l_allegrucci@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410251045.09370.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25 2004, Lorenzo Allegrucci wrote:
> On Sunday 24 October 2004 22:02, Lorenzo Allegrucci wrote:
> > On Sunday 24 October 2004 16:20, Lorenzo Allegrucci wrote:
> > > On Sunday 24 October 2004 14:30, Jens Axboe wrote:
> > > > On Sat, Oct 23 2004, Lorenzo Allegrucci wrote:
> > > > > 
> > > > > 100% reproducible with elevator=cfq
> > > > 
> > > > but not with the other io schedulers?
> > > 
> > > No, now I can reproduce it with the anticipatory scheduler too.
> > 
> > I've just got the same oops using XFS instead of ext3.
> 
> And disabling CONFIG_PREEMPT_BKL doesn't help.

I'll try to reproduce it here now.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTLaLVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbTLaLVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:21:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20099 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265209AbTLaLVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:21:30 -0500
Date: Wed, 31 Dec 2003 12:21:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Molina <tmolina@cablespeed.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031231112119.GB3089@suse.de>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com> <20031230222403.GA8412@k3.hellgate.ch> <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain> <20031231101741.GA4378@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231101741.GA4378@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31 2003, Roger Luethi wrote:
> On Tue, 30 Dec 2003 19:33:06 -0500, Thomas Molina wrote:
> > If I am understanding you, you would like data on 2.5.27, 2.5.38, and 
> > 2.5.39.  I'll do it if it will help something.  I'll look at it in the 
> 
> Thanks. 2.5.39 alone will do, actually. I'm just curious how far the
> similarity between qsbench and bk export goes.

2.5.39 is when the deadline io scheduler was merged. How do you define
the qsbench suckiness? Do you have numbers for 2.4.x and 2.6.1-rc with
the various io schedulers (it would be interesting to see stock,
elevator=deadline, and elevator=noop).

-- 
Jens Axboe


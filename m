Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbTH1Trq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTH1Trq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:47:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32979 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264194AbTH1Tro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:47:44 -0400
Date: Thu, 28 Aug 2003 21:47:43 +0200
From: Jens Axboe <axboe@suse.de>
To: David Nielsen <Lovechild@foolclan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the CFQ scheduler
Message-ID: <20030828194743.GH16684@suse.de>
References: <1062078948.17363.4.camel@pilot.stavtrup-st.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062078948.17363.4.camel@pilot.stavtrup-st.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28 2003, David Nielsen wrote:
> What ever happened to Jens Axboe's CFQ scheduler - as a regular users I
> really enjoyed the CFQ scheduler as it made my desktop feel a bit
> smoother. 
> 
> Is any work at all been done to this fine piece of code or has it been
> dropped completely in favor of AS ?

I'm glad you enjoyed it. No CFQ hasn't been dropped, it was/is just on
hold waiting for the loadable scheduler infrastructure. The reason for
that is that I made lots of changes to that code base, not the old one
that was in -mm.

It shouldn't be too hard to adapt the latest version from before -mm
dropped it and adapting to the current kernels. If you want to give that
a go, I'd be happy to help you out.

-- 
Jens Axboe


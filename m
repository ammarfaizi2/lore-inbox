Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUKUBpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUKUBpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 20:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUKUBpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 20:45:14 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:31961 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261682AbUKUBoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:44:05 -0500
Date: Sun, 21 Nov 2004 02:43:50 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041121014350.GJ4999@zaphods.net>
References: <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116170527.GA3525@mail.muni.cz>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 06:05:27PM +0100, Lukas Hejtmanek wrote:
> > Definately. I suspect XFS is unable to handle OOM graciously, or some other
> > problem.
> It seems that both Stefan and me are using XFS. Does someone have this problems
> with another filesystem? Unfortunately I cannot change fs. Can you Stefen?
Yes, i'll switch to EXT2 now. We'll see. Needs about 1d to fill up again and
i think if there is no filesystem corruption after say 5d i'll blame xfs. ;)

	Stefan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUJOKpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUJOKpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJOKpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:45:52 -0400
Received: from holomorphy.com ([207.189.100.168]:48008 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267595AbUJOKpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:45:46 -0400
Date: Fri, 15 Oct 2004 03:45:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: per-process shared information
Message-ID: <20041015104543.GE5607@holomorphy.com>
References: <20041013231042.GQ17849@dualathlon.random> <20041014214711.GF6899@logos.cnet> <20041014235845.GL17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014235845.GL17849@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 06:47:11PM -0300, Marcelo Tosatti wrote:
>> Nick has been working on that lately I think. What is the problem?

On Fri, Oct 15, 2004 at 01:58:45AM +0200, Andrea Arcangeli wrote:
> things went worse with the switch from 2.6.8 to 2.6.9-rc, so that's not
> the nr_swap_pages > 0, likely the latest changes introduced regressions
> instead of fixing them.
> I'm seeing both hard deadlocks and suprious oom kills, and that all
> makes sense, I can see the bugs, it's just I need to fix them, my plan
> is to forward port some code from 2.4 which works fine, objrmap will make
> it even better.

I'm not aware of these. If you could relay some of that information to
me (SuSE bugzilla numbers and similar are fine) I'd be much obliged.


-- wli

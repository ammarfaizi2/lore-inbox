Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267175AbUHITyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUHITyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUHITyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:54:09 -0400
Received: from holomorphy.com ([207.189.100.168]:27618 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266921AbUHITxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:53:37 -0400
Date: Mon, 9 Aug 2004 12:53:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809195323.GU11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091217.50786.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, akpm wrote:
>>> I'd be suspecting one of the CPU scheduler patches.

On Monday, August 9, 2004 11:32 am, Jesse Barnes wrote:
>> Yep, that's what I'm looking at now...

On Mon, Aug 09, 2004 at 12:17:50PM -0700, Jesse Barnes wrote:
> If I apply everything up to and including schedstat-v10.patch, it
> boots fine. So it might be sched-init_idle-fork_by_hand-consolidation.patch
> or something nearby...  Just reverting the sched-single-array.patch
> wasn't enough.

I can reproduce here (ia64/Altix). Fixing.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUGMOOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUGMOOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUGMOOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:14:25 -0400
Received: from holomorphy.com ([207.189.100.168]:32149 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265214AbUGMOOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:14:19 -0400
Date: Tue, 13 Jul 2004 07:13:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713141355.GD21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3DACC.9070703@yahoo.com.au> <20040713125331.GA21066@holomorphy.com> <40F3DC52.1030308@yahoo.com.au> <20040713130448.GB21066@holomorphy.com> <40F3DF31.3000003@yahoo.com.au> <20040713131944.GC21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713131944.GC21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 06:19:44AM -0700, William Lee Irwin III wrote:
> Let me spin up the CONFIG_PREEMPT=n fix and then I'll move on that.

smp_lock.h and hardirq.h for all arches -- some of which may not have
CONFIG_PREEMPT. -EWONTFIX. So the "workaround" stays.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUHFOzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUHFOzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUHFOzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:55:53 -0400
Received: from holomorphy.com ([207.189.100.168]:50124 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265993AbUHFOz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:55:28 -0400
Date: Fri, 6 Aug 2004 07:54:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-ia64@vger.kernel.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.7, ia64] continual memory leak at ~102kB/s...
Message-ID: <20040806145451.GI17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Blueman <daniel.blueman@gmx.net>, linux-ia64@vger.kernel.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <20029.1091803458@www55.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20029.1091803458@www55.gmx.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 04:44:18PM +0200, Daniel Blueman wrote:
> When running 2.6.7 on a generic ia64 system, I see memory being leaked in
> the kernel. Most of the fancy (preempt, hot-plug procs, ...) features are
> disabled, and the system in a quiescent state [1].
> /proc/meminfo shows the memory as unaccounted for [2], so it seems likely it
> has been kmalloc()d somehere. A small script shows memory disappearing at
> 102kB/s [3].
> Anyone else seen this on ia64?

Could you dump /proc/slabinfo?


-- wli

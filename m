Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTH1QzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263501AbTH1QzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:55:07 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34568
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263430AbTH1QzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:55:05 -0400
Date: Thu, 28 Aug 2003 09:55:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@osdl.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030828165504.GA21352@matchmail.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.24623.273818.861350@wombat.chubb.wattle.id.au> <20030827075143.GX4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827075143.GX4306@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 12:51:43AM -0700, William Lee Irwin III wrote:
> On Wed, Aug 27, 2003 at 05:39:27PM +1000, Peter Chubb wrote:
> > It's unclear what `swaps' are in Linux.  Traditionally, this rusage
> > field was the number of complete swapouts --- I'm not sure what the
> > equivalent is when processes are not swapped out holus-bolus, but are
> > paged gradually.
> 
> We don't have load control yet; the counters should probably be removed
> until we do.

Why not just count the number of pages swapped in/out per process?  I'm sure
that would be helpful for VM tools polling for stats from userspace...  And
even in the development of load control.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTE0CCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTE0CCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:02:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43986
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262513AbTE0CCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:02:01 -0400
Date: Tue, 27 May 2003 04:15:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, davem@redhat.com,
       davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527021513.GN3767@dualathlon.random>
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527015307.GC8978@holomorphy.com> <20030526185920.64e9751f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526185920.64e9751f.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:59:20PM -0700, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > In
> >  the userspace implementation the reprogramming is done infrequently
> >  enough to make even significant cost negligible; in-kernel the cost
> >  is entirely uncontrolled and the rate of reprogramming unlimited.
> 
> eh?
> 
> #define MAX_BALANCED_IRQ_INTERVAL       (5*HZ)
> #define MIN_BALANCED_IRQ_INTERVAL       (HZ/2)

Yep.

Andrea

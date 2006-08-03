Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWHCXqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWHCXqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWHCXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:46:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751405AbWHCXqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:46:51 -0400
Date: Fri, 4 Aug 2006 01:46:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Message-ID: <20060803234648.GK25692@stusta.de>
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:57:32PM -0700, Nate Diller wrote:

> This patch removes the Deadline I/O scheduler.  Performance-wise, it
> should be superceeded by the Elevator I/O scheduler in the following
> patch.  I would be very ineterested in hearing about any workloads or
> benchmarks where Deadline is a substantial improvement over Elevator,
> in throughput, fairness, latency, anything.
>...

You are starting with the last step.

First, get your Elevator I/O scheduler reviewed [1] and show some data 
that backs your "it should be superceeded by the Elevator I/O scheduler" 
claim.

Then get your Elevator I/O scheduler included in Linus' tree.

Then you might perhaps schedule the Deadline I/O scheduler for removal.

cu
Adrian

[1] that's essentially what is done by your second patch

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli


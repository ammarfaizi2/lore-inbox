Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWHDEYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWHDEYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 00:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWHDEYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 00:24:16 -0400
Received: from brick.kernel.dk ([62.242.22.158]:45321 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030246AbWHDEYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 00:24:15 -0400
Date: Fri, 4 Aug 2006 06:24:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Message-ID: <20060804042454.GN16754@suse.de>
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03 2006, Nate Diller wrote:
> This patch removes the Deadline I/O scheduler.  Performance-wise, it
> should be superceeded by the Elevator I/O scheduler in the following
> patch.  I would be very ineterested in hearing about any workloads or
> benchmarks where Deadline is a substantial improvement over Elevator,
> in throughput, fairness, latency, anything.

Strong NAK. deadline is a simple, working scheduler. Why on earth would
you want to remove it?

-- 
Jens Axboe


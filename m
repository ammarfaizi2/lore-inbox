Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSKRQaz>; Mon, 18 Nov 2002 11:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSKRQaz>; Mon, 18 Nov 2002 11:30:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62426 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262937AbSKRQax>; Mon, 18 Nov 2002 11:30:53 -0500
Date: Mon, 18 Nov 2002 08:34:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: mingo@elte.hu, rml@tech9.net, riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
Message-ID: <705474709.1037608454@[10.10.2.3]>
In-Reply-To: <20021118081854.GJ23425@holomorphy.com>
References: <20021118081854.GJ23425@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 16x, 2.5.47 kernel compiles take about 26s when the machine is
> otherwise idle.
> 
> On 32x, 2.5.47 kernel compiles take about 48s when the machine is 
> otherwise idle.
> 
> When a single-threaded task consumes an entire cpu, kernel compiles
> take 36s on 32s when the machine is idle aside from the task consuming
> that cpu and the kernel compile itself.
> 
> I suspect the scheduler, because cpu reporting in top(1) shows that a
> two or more cpu-intensive tasks are concentrated on the same cpu, and
> some long-lived tasks appear to be "bouncing" across cpus. If someone
> with knowledge and/or expertise with respect to scheduling semantics
> could look into this, I would be much obliged. Resolving this would
> likely address many SMP and/or NUMA scheduling performance issues.

1. make -j <what?>

2. profiles?

3. Can you try the latest set of NUMA sched patches posted by Eric Focht?

M.


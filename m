Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWHCXej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWHCXej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHCXej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:34:39 -0400
Received: from xenotime.net ([66.160.160.81]:55215 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932464AbWHCXei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:34:38 -0400
Date: Thu, 3 Aug 2006 16:37:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Message-Id: <20060803163720.e9ba5f3a.rdunlap@xenotime.net>
In-Reply-To: <20060803233048.GA7265@redhat.com>
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
	<20060803233048.GA7265@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 19:30:48 -0400 Dave Jones wrote:

> On Thu, Aug 03, 2006 at 03:57:32PM -0700, Nate Diller wrote:
>  > This patch removes the Deadline I/O scheduler.  Performance-wise, it
>  > should be superceeded by the Elevator I/O scheduler in the following
>  > patch.  I would be very ineterested in hearing about any workloads or
>  > benchmarks where Deadline is a substantial improvement over Elevator,
>  > in throughput, fairness, latency, anything.
> 
> Its somewhat hard for folks to offer comparative benchmarks when you
> remove something.  Without any numbers at all showing why your elevator
> is superior, removing anything seems very premature.
> 
> I'm also not convinced that removing an elevator at all is a good idea,
> as it'll cause regressions for anyone who has boot scripts that set
> certain mounts to use deadline for eg.

Shouldn't the usual feature-removal in N months be used here?
if at all.
(Documentation/feature-removal-schedule.txt)

---
~Randy

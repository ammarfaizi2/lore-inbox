Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWHCXOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHCXOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWHCXOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:14:52 -0400
Received: from xenotime.net ([66.160.160.81]:61605 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751350AbWHCXOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:14:52 -0400
Date: Thu, 3 Aug 2006 16:17:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Message-Id: <20060803161734.ca781a36.rdunlap@xenotime.net>
In-Reply-To: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 15:57:32 -0700 Nate Diller wrote:

> This patch removes the Deadline I/O scheduler.  Performance-wise, it
> should be superceeded by the Elevator I/O scheduler in the following
> patch.  I would be very ineterested in hearing about any workloads or
> benchmarks where Deadline is a substantial improvement over Elevator,
> in throughput, fairness, latency, anything.
> 
> Signed-off-by: Nate Diller <nate.diller@gmail.com>
> 
> ---
>  Documentation/block/deadline-iosched.txt |   78 ---
>  block/Kconfig.iosched                    |   14
>  block/Makefile                           |    1
>  block/deadline-iosched.c                 |  801 -------------------------------
>  4 files changed, 894 deletions(-)

Several other files in Documentation/block/ need to be updated also, please.

---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTFEDVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTFEDVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:21:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6032 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264479AbTFEDVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:21:38 -0400
Date: Wed, 4 Jun 2003 20:35:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM7 fserver regressed in 2.5.70*
Message-Id: <20030604203509.2121a747.akpm@digeo.com>
In-Reply-To: <20030605024940.GA14406@rushmore>
References: <20030605024940.GA14406@rushmore>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 03:35:08.0817 (UTC) FILETIME=[7673A810:01C32B13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> Summary:
>  AIM7 fileserver workload behaviour changed with 2.5.70.
>  At low task counts (load average), 2.5.70* takes 40% 
>  longer than 2.5.69.  As task count increases, regression
>  disappears.
> 
>  Hardware has (4) 700 mhz P3 Xeons.
>  3.75 GB RAM
>  RAID 0 LUN (hardware raid)
> 
>  Background:
>  AIM7 fserver is the only regressed workload.  In general, 
>  2.5.70* has better numbers than 2.5.69* for a variety of
>  benchmarks.
> 
>  Part of the improvement in 2.5.70 I/O benchmarks is
>  from a fiber channel configuration change.  2.5.70* has
>  two online fiber channels.  Earlier kernels had only one
>  fiber channel online.  
> 
>  Tiobench and bonnie++ show about 10% improvement.  
>  LMbench microbenchmarks are generally improving or stable
>  in recent 2.5.x.  

I'd assume that the improvements would be wholly due to the
IO controller changes?  Are you saying that there is something
else involved?

If you could share the jobfile and means-to-reproduce I can
take a look, thanks.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTEGWdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTEGWdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:33:02 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40232 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264118AbTEGWdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:33:02 -0400
Date: Wed, 7 May 2003 15:41:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.69
Message-Id: <20030507154150.005db55e.akpm@digeo.com>
In-Reply-To: <20030507175422.GX3989@ca-server1.us.oracle.com>
References: <20030507175422.GX3989@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 22:45:32.0287 (UTC) FILETIME=[5DAA98F0:01C314EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> WimMark I report for 2.5.69
> 
> Runs:  1462.17 1005.78 1995.99
> ...
> This benchmark is sensitive to random system events.

You can say that again.

> I run three runs because of this.  If two runs are nearly identical and the
> remaining run is way off, that run should probably be ignored (it is
> often a low number, signifying that something on the system impacted
> the benchmark).

Here we have 1.0, 1.5 and 2.0.

We need to understand why there is such variation.  If we can do that,
then perhaps we can make those 1.0's and 1.5's go away.

Is that a thing you can work on?  One approach would be to vary parameters
(filesystem type, amount of memory, TCQ lengths, workload, whatever) and
see which ones the throughput is sensitive to.


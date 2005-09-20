Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbVITOMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbVITOMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbVITOMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:12:49 -0400
Received: from web33306.mail.mud.yahoo.com ([68.142.206.121]:30805 "HELO
	web33306.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932751AbVITOMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:12:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sioAg0WH6cSx8QkWWtW++n9p9Mrdvcu67WcBw+lqc1iFqTGfviB9LjKNlKsrE9ytoyJskDQX3WxxPYoVFcnqO9OnGMGslKWge1k3dV+BjxXe3I4lms/P4JnU9oA5FdvxJkHf6j/4kmK7BqbMAvEXzJOOkDT5tAeyJoO5Vdyuey8=  ;
Message-ID: <20050920141248.55369.qmail@web33306.mail.mud.yahoo.com>
Date: Tue, 20 Sep 2005 07:12:48 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Quick update on latest Linux kernel performance
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200509132132.j8DLWJg04553@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- "Chen, Kenneth W" <kenneth.w.chen@intel.com>
wrote:

> New performance result are posted on
> http://kernel-perf.sourceforge.net
> with latest data collected on kernel
> 2.6.13-git9.
> 
> Kernel-build bench are fairly stable over the
> last 14 kernel versions
> or so.  It was consistently 3-5% better on
> x86_64 over baseline 2.6.9
> kernel.  It showed a lot smaller gain on ia64
> though.
> 
> Java business benchmark showed very little
> change in performance on all
> kernel versions.
> 
> Volanomark took some heavy performance hit
> during 2.6.12-rc* period, but
> come back in 2.6.13 on x86_64 configuration. 
> Though latest 2.6.13-git9
> showed a little bit perf. regression.
> 
> Netperf is showing wildly result, especially
> the 1-byte request/response
> component.  Overall, UDP portion Of the netperf
> are showing nice improvement
> over baseline 2.6.9 kernel.
> 
> Industry standard transaction processing
> database workload still suffering
> 13% performance regression with 2.6.13. (data
> will be posted in a separate mail)
> 
> Take a look at the performance data.  Comments
> and suggestions are always
> welcome and please post them to LKML.

Does it still drop packets when only running at
15% utilization?

Did you run data streams through the box while
doing these tests? There's a difference between
gaining performance in a benchmark and just
shifting performance from one activity to
another. If the latter is the case, then there's
been no progress at all. I keep seeing all these
great benchmark results, and linux keeps dropping
more and more packets as the versions increase.
Its become practically unusable as a specialized
networking appliance.

Danial




		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWEGQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWEGQZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWEGQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:25:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25062 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932170AbWEGQZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:25:48 -0400
Subject: Re: [PATCH] Direct I/O bio size regression
From: Lee Revell <rlrevell@joe-job.com>
To: David Chinner <dgc@sgi.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060426023031.GH611708@melbourne.sgi.com>
References: <20060424061403.GF611708@melbourne.sgi.com>
	 <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de>
	 <20060424145635.GH611485@melbourne.sgi.com>
	 <20060424184730.GH29724@suse.de>
	 <20060426023031.GH611708@melbourne.sgi.com>
Content-Type: text/plain
Date: Sun, 07 May 2006 12:25:45 -0400
Message-Id: <1147019145.15364.236.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 12:30 +1000, David Chinner wrote:
> Got any data that you can share with us?
> 

The thread was from July 2004 and was called:



Re: [linux-audio-dev] Re: [announce]
[patch] Voluntary Kernel Preemption
Patch

Also some info in thread:



Re: [patch]
voluntary-preempt-2.6.8-rc2-M5

> Wrt latency, is the problem to do with large requests causing short
> term latency? I thought that latency minimisation is the job of the
> I/O scheduler, so if this is the case, doesn't this indicate a
> deficiency of the I/O scheduler? e.g. the I/o scheduler could split
> large requests to reduce latency, just like you merge adjacent
> requests to reduce the number of I/Os and keep overall latency
> low...
> 

I think you are talking past each other - Jens is referring to scheduler
latency, not IO latency.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267530AbUGWEN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267530AbUGWEN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 00:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUGWEN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 00:13:57 -0400
Received: from [192.48.179.6] ([192.48.179.6]:29275 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267530AbUGWENz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 00:13:55 -0400
Date: Thu, 22 Jul 2004 23:13:49 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch for isolated scheduler domains
Message-ID: <20040723041349.GB15188@sgi.com>
References: <20040722164126.GB13189@sgi.com> <20040722175459.GA30059@elte.hu> <4100859C.9060409@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4100859C.9060409@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 01:27:24PM +1000, Nick Piggin wrote:
> Cool. Have you actually tried running it? With Ingo's correction, it
> should work fine but I don't think anyone has tested this.
> 
Yup, I've been running it on an Altix.

I've created a version for sched.c (all platform) which I'll be posting
soon.  That will include code for both CONFIG_NUMA_SCHED and non
CONFIG_NUMA_SCHED configurations.

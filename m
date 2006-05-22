Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWEVSJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWEVSJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWEVSJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:09:36 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:63380 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S1751109AbWEVSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:09:35 -0400
Message-ID: <4471FE52.8090107@am.sony.com>
Date: Mon, 22 May 2006 11:09:22 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org,
       Balbir Singh <balbir@in.ibm.com>
Subject: netlink vs. debugfs (was Re: [Patch 0/6] statistics infrastructure)
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060519092411.6b859b51.akpm@osdl.org>
In-Reply-To: <20060519092411.6b859b51.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Peschke <mp3@de.ibm.com> wrote:
>> My patch series is a proposal for a generic implementation of statistics.
> 
> This uses debugfs for the user interface, but the
> per-task-delay-accounting-*.patch series from Balbir creates an extensible
> netlink-based system for passing instrumentation results back to userspace.
> 
> Can this code be converted to use those netlink interfaces, or is Balbir's
> approach unsuitable, or hasn't it even been considered, or what?

Can someone give me the 20-second elevator pitch on why
netlink is preferred over debugfs?  I've heard of a
number of debugfs/procfs users requested to switch over.

Thanks,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

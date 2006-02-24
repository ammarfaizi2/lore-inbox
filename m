Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWBXBAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBXBAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWBXBAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:00:05 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:46747 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932246AbWBXBAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:00:04 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: smpnice -- apply review suggestions
Date: Fri, 24 Feb 2006 11:59:27 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       John Hawkes <hawkes@sgi.com>
References: <43FD0CA8.6060701@bigpond.net.au>
In-Reply-To: <43FD0CA8.6060701@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241159.28292.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 12:15, Peter Williams wrote:
> This patch applies the suggestions made by Con Kolivas for improving the
> smpnice code.
>
> The non cosmetic part of the patch addresses the fact the mapping from
> nice values to task load weights for negative nice values does not match
> the implied CPU allocations in the function task_timeslice().  As
> suggested by Con the mapping function now uses the time slice
> information directly (via a slightly modified interface).

Looks good to me.

> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
Signed-off-by: Con Kolivas <kernel@kolivas.org>

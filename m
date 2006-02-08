Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWBHRli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWBHRli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWBHRlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:41:37 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:32473 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1030269AbWBHRlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:41:37 -0500
Date: Wed, 8 Feb 2006 11:41:21 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] SLOB=y && SMP=y fix
Message-ID: <20060208174121.GO13729@waste.org>
References: <20060208091156.GA7663@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208091156.GA7663@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 10:11:56AM +0100, Ingo Molnar wrote:
> fix CONFIG_SLOB=y (when CONFIG_SMP=y): get rid of the 'align' parameter 
> from its __alloc_percpu() implementation. Boot-tested on x86.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Thanks.

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUGWPa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUGWPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267796AbUGWPa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:30:28 -0400
Received: from cfcafwp.sgi.com ([192.48.179.6]:43305 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267795AbUGWPa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:30:27 -0400
Date: Fri, 23 Jul 2004 10:30:22 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] consolidate sched domains
Message-ID: <20040723153022.GA16563@sgi.com>
References: <41008386.9060009@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41008386.9060009@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 01:18:30PM +1000, Nick Piggin wrote:
> The attached patch is against 2.6.8-rc1-mm1. Tested on SMP, UP and SMP+HT
> here and it seems to be OK.
> 
> I have included the cpu_sibling_map for ppc64, although Anton said he did
> have an implementation floating around which he would probably prefer, but
> I'll let him deal with that.

Do other architectures need to define their own cpu_sibling_maps, or am I
missing something that would define that for IA64 and others?


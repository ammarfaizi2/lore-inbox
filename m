Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWEOKVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWEOKVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWEOKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:21:06 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:27146 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964860AbWEOKVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:21:05 -0400
Message-ID: <446855AF.1090100@shadowen.org>
Date: Mon, 15 May 2006 11:19:27 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@csn.ul.ie>,
       davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet> <20060514203158.216a966e.akpm@osdl.org> <44683A09.2060404@shadowen.org> <44685123.7040501@yahoo.com.au>
In-Reply-To: <44685123.7040501@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andy Whitcroft wrote:
> 
>> Interesting.  You are correct there was no config component, at the time
>> I didn't have direct evidence that any architecture needed it, only that
>> we had an unchecked requirement on zones, a requirement that had only
>> recently arrived with the changes to free buddy detection.  I note that
> 
> 
> Recently arrived? Over a year ago with the no-buddy-bitmap patches,
> right? Just checking because I that's what I'm assuming broke it...

Yep, sorry I forget I was out of the game for 6 months!  And yes that
was when the requirements were altered.

-apw

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWB0Pnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWB0Pnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWB0Pnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:43:45 -0500
Received: from fmr20.intel.com ([134.134.136.19]:60623 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964789AbWB0Pno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:43:44 -0500
Message-ID: <44031E13.2050303@linux.intel.com>
Date: Mon, 27 Feb 2006 16:43:15 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [Patch 0/4] Reordering of functions, try 2
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <200602271636.26064.ak@suse.de>
In-Reply-To: <200602271636.26064.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 27 February 2006 16:23, Arjan van de Ven wrote:
> 
>> 2) In the "processor/processes" group, 7 tests changed behavior, and the
>> average of these changes was a performance increase by 10% (!!). The
>> exception was the signal handling test, which decreased by 6%. This
>> actually made me feel good, since the original function list was based
>> on a profile run that didn't do signals much if at all.
> 
> How often did you rerun lmbench each time?

I ran it 5 times each time and then took the average of the runs
(yes that takes forever)

> In my experience the numbers
> are somewhat unstable. Still looks encouraging.



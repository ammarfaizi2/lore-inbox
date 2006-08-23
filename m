Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWHWN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWHWN6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWHWN6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:58:21 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:61692 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S964893AbWHWN6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:58:21 -0400
Date: Wed, 23 Aug 2006 06:48:15 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823134815.GH697@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <200608231429.04413.ak@suse.de> <20060823125843.GF697@frankl.hpl.hp.com> <200608231544.26756.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608231544.26756.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 03:44:26PM +0200, Andi Kleen wrote:
> > If they have variations it could be with
> > the low power (laptop) models where counters may not be present at all.
> 
> It would surprise me if they ever released anything again with no counters.
> 
> It's mainly simulators where the counters are missing (e.g. SimNow is a pretty 
> accurate simulation otherwise, but doesn't have performance counters)
> 
Ah yes simulators are a good example. Yet what matters is whether or not they
would fault on access to the MSR. It is okay if they implement the MSR but
they do not count anything, nor trigger interrupts. The IA-64 ski simulator is
like this and this is just fine, all you get is zeroes and you cannot sample.

-- 
-Stephane

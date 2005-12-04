Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVLDUN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLDUN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVLDUN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:13:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:56023 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932322AbVLDUN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:13:57 -0500
Date: Sun, 4 Dec 2005 21:13:42 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051204201342.GF14247@wotan.suse.de>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133725767.19768.12.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 02:49:26PM -0500, Lee Revell wrote:
> On Sun, 2005-12-04 at 19:32 +0100, Andi Kleen wrote:
> > On Sun, Dec 04, 2005 at 05:43:35PM +0100, Dominik Brodowski wrote:
> > > On Fri, Dec 02, 2005 at 10:43:20AM -0800, Venkatesh Pallipadi wrote:
> > > > The patch below changes this to:
> > > > Show the last known frequency of the particular CPU, when cpufreq is present. If
> > > > cpu doesnot support changing of frequency through cpufreq, then boot frequency 
> > > > will be shown. The patch affects i386, x86_64 and ia64 architectures.
> > > 
> > > Looks good to me -- however, might this affect userspace cpufreq tools? I'd
> > 
> > They normally use /sys anyways.
> 
> Wrong, lots of userspace programs that need to know the CPU speed get it
> from /proc/cpuinfo.  It would be nice if there were a better API.

Talking about user space governours - I presume that is what 
Dominik ment with "userspace cpufreq tools"

> As long as you don't change the file format it should be OK.

Great that we have your approval.

-Andi

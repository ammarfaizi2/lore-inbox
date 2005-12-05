Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVLER1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVLER1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVLER1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:27:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932468AbVLER07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:26:59 -0500
Date: Mon, 5 Dec 2005 12:26:51 -0500
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051205172651.GC12664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com> <439463C4.7040905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439463C4.7040905@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 10:59:00AM -0500, Mark Lord wrote:
 > >I can't think of a single valid reason why a program would want
                                                 ^^^^^^^
 > >to know the MHz rating of a CPU.
 > 
 > Humans like to know what their machines are doing.

humans != programs

 > Simple as that:  it's for the end-users, and the place they look
 > for it is always /proc/cpuinfo (since that works on every platform
 > and on kernels prior to the 2.[56].* series.

Sure, 'cat' is the only reason its there at all.

 > Not useful as an accurate number for any programming algorithms,
 > but it is used to satisfy human curiosity.  A lot.

I think we're in agreement, aren't we? :)

		Dave

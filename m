Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVLERZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVLERZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVLERZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:25:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932466AbVLERZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:25:30 -0500
Date: Mon, 5 Dec 2005 12:25:13 -0500
From: Dave Jones <davej@redhat.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051205172513.GB12664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com> <20051205130224.GC17993@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205130224.GC17993@harddisk-recovery.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 02:02:24PM +0100, Erik Mouw wrote:
 > On Sun, Dec 04, 2005 at 08:16:11PM -0500, Dave Jones wrote:
 > > I can't think of a single valid reason why a program would want
 > > to know the MHz rating of a CPU. Given that it's a) approximate,
 > > b) subject to change due to power management, c) completely nonsensical
 > > across CPU vendors, and d) only one of many variables regarding CPU
 > > performance, any program that bases any decision on the values found
 > > by parsing that field of /proc/cpuinfo is utterly broken beyond belief.
 > 
 > If you want a userspace governor to change the CPU speed, you need to
 > export the value to userland. 

We have sysfs files for that.

		Dave


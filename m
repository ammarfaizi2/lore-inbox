Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUCSArD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUCSAqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:46:48 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:22469 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263002AbUCSAnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:43:02 -0500
Date: Thu, 18 Mar 2004 19:43:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Kenneth Chen <kenneth.w.chen@intel.com>,
       linux-ia64@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       CPU Freq ML <cpufreq@www.linux.org.uk>
Subject: Re: add lowpower_idle sysctl
In-Reply-To: <405A29EA.6000400@mvista.com>
Message-ID: <Pine.LNX.4.58.0403181942420.28447@montezuma.fsmlabs.com>
References: <20040317170436.430acfbe.akpm@osdl.org>
 <200403180318.i2I3IDF03166@unix-os.sc.intel.com> <20040317192821.1fe90f24.akpm@osdl.org>
 <Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com> <405A29EA.6000400@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Todd Poynor wrote:

> Zwane Mwaikambo wrote:
>
> >>Set some system-wide integer via a sysctl and let the particular
> >>architecture decide how best to implement the currently-selected idle mode?
> >
> > I'm wondering whether the setting of these magic numbers can't be done
> > using cpufreq infrastructure.
>
> I'd vote for using Patrick Mochel's PM subsystem and use a standard set
> of identifiers that are mapped to a platform-specific idle behavior, in
> much the same way as platform suspend modes are handled today.  For
> example, strings echoed to /sys/power/idle could be an interface.  If
> folks are amenable to this I'd be happy to supply a (generic) patch for it.

Ta, sounds good, give us a look.


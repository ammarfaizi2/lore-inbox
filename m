Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUCSAJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbUCSAJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:09:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:50892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263378AbUCSAIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:08:00 -0500
Date: Thu, 18 Mar 2004 16:09:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Todd Poynor <tpoynor@mvista.com>
Cc: zwane@linuxpower.ca, kenneth.w.chen@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: add lowpower_idle sysctl
Message-Id: <20040318160913.5915281d.akpm@osdl.org>
In-Reply-To: <405A29EA.6000400@mvista.com>
References: <20040317170436.430acfbe.akpm@osdl.org>
	<200403180318.i2I3IDF03166@unix-os.sc.intel.com>
	<20040317192821.1fe90f24.akpm@osdl.org>
	<Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com>
	<405A29EA.6000400@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Poynor <tpoynor@mvista.com> wrote:
>
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

That sounds suitable, thanks.

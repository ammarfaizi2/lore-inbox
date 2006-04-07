Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWDGLOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWDGLOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGLOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:14:52 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:27829
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932428AbWDGLOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:14:51 -0400
Date: Fri, 7 Apr 2006 04:14:44 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407111444.GA12458@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org> <20060407071125.GA2563@elte.hu> <20060407083931.GA11393@gnuppy.monkey.org> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <20060407105141.GA9972@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407105141.GA9972@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 12:51:41PM +0200, Ingo Molnar wrote:
> no, i'm discussing precisely the point you raised:

Oh boy.

> >>> You should consider for a moment to allow for the binding of a 
> >>> thread to a CPU to determine the behavior of a SCHED_FIFO class task 
> >>> instead of creating a new run category. [...]
> 
> with the observation that 1) binding is already possible [so your 
> suggestion is apparently knocking on open doors] 2) binding is a 
> separate mechanism (not adequate for all workloads) and it is thus 
> orthogonal to what i'm trying to achieve with the "RT overload" stuff.  
> Really simple and straightforward observations i think.

This is going to take some time to get the terminology right. It's
late now and I'll have to continue this tomorrow.

First thing's first, SCHED_FIFO_GLOBAL for what you want in the main
line is the same thing as SCHED_FIFO in -rt, right ?

bill


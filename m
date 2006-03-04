Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWCDHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCDHCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 02:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWCDHCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 02:02:13 -0500
Received: from mail.gmx.de ([213.165.64.20]:56214 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751039AbWCDHCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 02:02:12 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling
	patch 1 of 2
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, pwil3058@bigpond.net.au,
       linux-kernel@vger.kernel.org, mingo@elte.hu, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, akpm@osdl.org
In-Reply-To: <200603041750.21484.kernel@kolivas.org>
References: <1140183903.14128.77.camel@homer>
	 <200603041654.59480.kernel@kolivas.org> <1141455048.9482.13.camel@homer>
	 <200603041750.21484.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 08:04:00 +0100
Message-Id: <1141455840.9482.19.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 17:50 +1100, Con Kolivas wrote:
> On Saturday 04 March 2006 17:50, Mike Galbraith wrote:
> > Well Fudgecicles.  Now you guys have gotten me aaaaall confused.  Are
> > there cpus out there (in generic linux land) that have 16 bit integers
> > or not?  16 bit integers existing in a 32 bit cpu OS seems like an alien
> > concept to me, but I'm not a twisted cpu designer... I'll just go with
> > the flow ;-)
> 
> All supported architectures on linux currently use 32bits for int. That should 
> give you 2.1 seconds in nanoseconds. Sorry my legacy of remembering when ints 
> were 8 bits coloured me.

Well that's a relief.  I was getting all kinds of frazzled trying to
imagine the kernel not exploding on such a cpu.

	-Mike


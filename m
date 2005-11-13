Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbVKPSjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbVKPSjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbVKPSjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:39:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42666 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030437AbVKPSjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:39:01 -0500
Date: Sun, 13 Nov 2005 19:59:44 +0000
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Alexander Clouter <alex-kernel@digriz.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davej@redhat.com, davej@codemonkey.org.uk,
       blaisorblade@yahoo.it
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051113195943.GD2193@spitz.ucw.cz>
References: <20051110151111.GA16994@inskipp.digriz.org.uk> <200511110248.58751.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511110248.58751.kernel@kolivas.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The use of the 'ignore_nice' sysfs file is confusing to anyone using it.
> > This removes the sysfs file 'ignore_nice' and in its place creates a
> > 'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes
> > are not counted towards the 'business' caclulation.
> 
> And just for the last time I'll argue that the default should be 0. I have yet 
> to discuss this with any laptop user who thinks that 1 is the correct default 
> for ondemand.

Me. I have graphics appp here (almara), that does user interaction in 
separate thread from real workers. Yet you want real workers to run...

And consider notebook on ac power, using ondemand for acoustic management.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


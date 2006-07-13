Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWGMNGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWGMNGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWGMNGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:06:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36871 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030183AbWGMNGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:06:24 -0400
Date: Thu, 13 Jul 2006 13:06:05 +0000
From: Pavel Machek <pavel@suse.cz>
To: "shin, jacob" <jacob.shin@amd.com>
Cc: "Deguara, Joachim" <joachim.deguara@amd.com>, Andi Kleen <ak@suse.de>,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Message-ID: <20060713130604.GC8230@ucw.cz>
References: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B3870AD84389624BAF87A3C7B831499302935A76@SAUSEXMB2.amd.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here are the further findings after letting the machine toggle between
> > 1GHz and 2.2Ghz every two seconds for roughly 24 hours.  Unfortunately
> > there is an oops after bringing CPU2 online and CPU3 will not come
> > online.  Still the differences in TSC are not bad:
> 
> Can I get more information on how to reproduce the Oops? Kernel version?
> .config? your hardware?
> 
> I have run basic set of CPU Hotplug on/offline tests, and I could not
> reproduce it..

Can you run two such tests *in parallel*? That seemed to break it
really quickly.

							Pavel
-- 
Thanks for all the (sleeping) penguins.

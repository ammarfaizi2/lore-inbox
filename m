Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUHQTyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUHQTyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUHQTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:54:24 -0400
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:62081 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266669AbUHQTyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:54:23 -0400
Date: Tue, 17 Aug 2004 21:54:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, Ray Bryant <raybry@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq deprecation
Message-ID: <20040817195410.GI19009@elf.ucw.cz>
References: <20040817105859.GA1497@elf.ucw.cz> <41221890.8070307@sgi.com> <20040817164509.GB19243@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817164509.GB19243@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > A scan of the lkml archives on theaimsgroup for cpufreq shows only this 
>  > message about deprecation.  Where was this discussed?
> 
> Probably cpufreq list around the time cpufreq was first merged to mainline 2.6.
> 
> I never wanted to really see the proc stuff hit 2.6 at all, but
> someone (maybe Dominik) suggested that as there were tools using it,
> (a multitude of cpu scaling daemons appeared), we should drag it into 2.6
> too, at least until the daemons caught up with the preferred
> interface.

I do not think changing interface in half of stable series is good
idea, but yes, it was market deprecated since day one. Keeping at
least read-only /proc/cpufreq would be nice. Or perhaps merging that
info into /proc/cpuinfo?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

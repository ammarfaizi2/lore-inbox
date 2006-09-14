Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWINTjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWINTjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWINTjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:39:19 -0400
Received: from diedas.soften.ktu.lt ([193.219.33.197]:23169 "EHLO
	diedas.soften.ktu.lt") by vger.kernel.org with ESMTP
	id S1751078AbWINTjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:39:18 -0400
Date: Thu, 14 Sep 2006 22:42:44 +0300 (EEST)
From: Almonas Petrasevicius <draugaz@diedas.soften.ktu.lt>
To: Ben B <kernel@bb.cactii.net>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       davej@codemonkey.org.uk
Subject: Re: speedstep-centrino broke
In-Reply-To: <20060914142242.GA28040@cactii.net>
Message-ID: <Pine.LNX.4.62.0609142105010.11604@diedas.soften.ktu.lt>
References: <Pine.LNX.4.62.0609141558090.22822@diedas.soften.ktu.lt>
 <20060914142242.GA28040@cactii.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Sep 2006, Ben B wrote:

>> I did verify both kernels 2.6.16 and 2.6.17 (both vanilla), there is
>> _no_ difference, both have the same speedstep problem.
>
> At the suggestion of Venki, I opened a bugzilla ticket on it:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=7157
>
> And the lowdown is that it seems the newer BIOS no longer exports the
> correct ACPI symbols which are required for speedstep, thus no longer
> supporting it (at least via the official methods). Hence it seems not a
> Linux kernel bug.

Could be. But I am still somehow puzzled, since neither of the 
previous versions (F04 & F06 in my case) contain any reference to the 
mentioned methods (_PSS & _PCT). But those versions were speedsteping just 
fine. 
Or maybe I don't know how to look.
Could You dump your "working" ACPI table and look for those two methods?

Regretfully I don't know much about the ACPI and ASL. It seems like a 
perfect occasion to get myself familiar with it.

> I opened a support ticket with HP, hopefully they address the issue. In

I am not holding my breath unless You know some magic word :)
Btw, that another OS is speedsteping just fine (or pretends doing so).

> the meantime I rolled back my bios and have cpufreq working again.
> Interesting that you also see the problem on an nc6320, it could be that
> they use the same BIOS codebase for various models.

But of course. I suspect, that aside from the physical layout it is 
basically the same hardware.

Regards,
Almonas

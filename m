Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWBXCjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWBXCjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWBXCjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:39:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38661 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750737AbWBXCjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:39:39 -0500
Date: Fri, 24 Feb 2006 03:39:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       davej@codemonkey.org.uk, Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060224023937.GC3674@stusta.de>
References: <20060214152218.GI10701@stusta.de> <200602240016.00317.ak@suse.de> <20060223233328.GB3674@stusta.de> <200602240055.30603.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240055.30603.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 12:55:30AM +0100, Andi Kleen wrote:
> On Friday 24 February 2006 00:33, Adrian Bunk wrote:
> 
> > EMBEDDED is the wrong option, since the semantics of embedded is "show
> > more options to allow additional space savings". It is not and should
> > not be abused as an option to hide random options from users.
> 
> I disagree. And I originally added most EMBEDDED users to the kernel.
> The purpose I added it for was to hide options that only useful
> for a very limited userbase but cause big or subtle trouble when set
> wrong. P4_CLOCKMOD clearly qualifies.

This matches neither the description of the EMBEDDED option nor all 
other usages in the kernel I have seen until now.

We need an additional option for such cases, but overloading EMBEDDED 
with more than one meaning is definitely not a good idea.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


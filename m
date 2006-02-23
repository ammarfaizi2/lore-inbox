Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWBWXda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBWXda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWBWXda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:33:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932127AbWBWXda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:33:30 -0500
Date: Fri, 24 Feb 2006 00:33:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       davej@codemonkey.org.uk, Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060223233328.GB3674@stusta.de>
References: <20060214152218.GI10701@stusta.de> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <200602240016.00317.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240016.00317.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 12:15:59AM +0100, Andi Kleen wrote:
> On Thursday 23 February 2006 21:41, Dave Jones wrote:
>...
> > As to the difference of EMBEDDED.. on 32bit, there's a lot more
> > systems without speedstep/powernow, so it makes more sense to
> > make it more widely available.  Nearly all AMD64/EM64T have
> > some form of speed-scaling which is more effective than p4-clockmod,
> > which is why I assume it's set that way.
> >
> > Andi can probably confirm the thinking on that one, as I think
> > he added it when x86-64 first started supporting cpufreq.
> 
> It should IMHO depend on EMBEDDED on i386 too because
> the uses are extremly specialized (if there are any) and most users setting it 
> probably set it by mistake because they misunderstand it.

EMBEDDED is the wrong option, since the semantics of embedded is "show 
more options to allow additional space savings". It is not and should 
not be abused as an option to hide random options from users.

Currently, EXPERIMENTAL is nearer to what suits X86_P4_CLOCKMOD, and it 
seems we really need an ADVANCED_USER option for such options.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


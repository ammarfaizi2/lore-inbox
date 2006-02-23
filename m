Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWBWXOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWBWXOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWBWXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:14:32 -0500
Received: from ns2.suse.de ([195.135.220.15]:10626 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751806AbWBWXOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:14:32 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Status of X86_P4_CLOCKMOD?
Date: Fri, 24 Feb 2006 00:15:59 +0100
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, Dmitry Torokhov <dtor_core@ameritech.net>,
       davej@codemonkey.org.uk, Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com>
In-Reply-To: <20060223204110.GE6213@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240016.00317.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 21:41, Dave Jones wrote:

> It's really of limited practical use, but occasionally, we find
> some users that do find it handy.  (One case I heard was someone
> with a server farm that generated lots of heat, but at nighttime,
> he could throttle that back, which resulted in a drop in overall
> temperature in the serverroom -- no numbers to back it up though,
> just anecdotes).

Perhaps they should just turn some computers off over night then.

Another drawback is that adds very long latencies. e.g. when it is
enabled you can really end up with desktops where the mouse
doesn't react for a very visible to humans delay.

And it'll mess up kernel timing in general.

> As to the difference of EMBEDDED.. on 32bit, there's a lot more
> systems without speedstep/powernow, so it makes more sense to
> make it more widely available.  Nearly all AMD64/EM64T have
> some form of speed-scaling which is more effective than p4-clockmod,
> which is why I assume it's set that way.
>
> Andi can probably confirm the thinking on that one, as I think
> he added it when x86-64 first started supporting cpufreq.

It should IMHO depend on EMBEDDED on i386 too because
the uses are extremly specialized (if there are any) and most users setting it 
probably set it by mistake because they misunderstand it.

-Andi


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291198AbSBLVQc>; Tue, 12 Feb 2002 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291195AbSBLVQM>; Tue, 12 Feb 2002 16:16:12 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:3853 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S291192AbSBLVPk>;
	Tue, 12 Feb 2002 16:15:40 -0500
Date: Tue, 12 Feb 2002 18:14:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
Message-ID: <20020212171421.GE148@elf.ucw.cz>
In-Reply-To: <15464.33256.837784.657759@napali.hpl.hp.com> <20020211.185100.68039940.davem@redhat.com> <15464.34183.282646.869983@napali.hpl.hp.com> <20020211.190449.55725714.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211.190449.55725714.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    No, it will slow down ia64 and you haven't shown that it helps others.
> 
> That's crap.  You haven't shown this yet, it didn't slow down sparc64
> so I doubt you'll be able to.
> 
> You don't have any facts, you just "think" it will slow things down
> because of the pointer dereference.  I challenge you to show it
> actually shows up on the performance radar.
> 
> The thing is going to be fully hot in the cache all the time, there
> is no way you'll take a cache miss for this dereference.

So you essentially made your cache one cacheline smaller.

I guess it is easy to add 100 minor modifications, none of them
showing on performance radar, and slowing kernel 2 times in result.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

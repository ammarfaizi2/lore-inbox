Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288603AbSADL7o>; Fri, 4 Jan 2002 06:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288606AbSADL7e>; Fri, 4 Jan 2002 06:59:34 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:13456 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S288603AbSADL71>; Fri, 4 Jan 2002 06:59:27 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dieter Nutzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Date: Fri, 4 Jan 2002 03:33:19 -0800 (PST)
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201041242500.2247-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201040330460.7718-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Ingo Molnar wrote:

> On Fri, 4 Jan 2002, David Lang wrote:
>
> > Ingo,
> > back in the 2.4.4-2.4.5 days when we experimented with the
> > child-runs-first scheduling patch we ran into quite a few programs that
> > died or locked up due to this. (I had a couple myself and heard of others)
>
> hm, Andrea said that the only serious issue was in the sysvinit code,
> which should be fixed in any recent distro. Andrea?
>

I remember running into problems with some user apps (not lockups, but the
apps failed) on my 2x400MHz pentium box. I specificly remember the Citrix
client hanging, but I think there were others as well.

I'll try and get a chance to try your patch in the next couple days.

David Lang


 > > try switching this back to the current behaviour and
see if the > > lockups still happen.
>
> there must be some other bug as well, the child-runs-first scheduling can
> cause lockups, but it shouldnt cause oopes.
>
> 	Ingo
>

Return-Path: <linux-kernel-owner+w=401wt.eu-S1161275AbXAHXV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbXAHXV3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbXAHXV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:21:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3698 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161275AbXAHXV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:21:28 -0500
Date: Tue, 9 Jan 2007 00:21:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Yinghai Lu <yinghai.lu@amd.com>, Linus Torvalds <torvalds@osdl.org>,
       mingo@redhat.com, Tobias Diedrich <ranma+kernel@tdiedrich.de>
Subject: Re: [discuss] [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
Message-ID: <20070108232131.GA25007@stusta.de>
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com> <m1k5zxgplv.fsf@ebiederm.dsl.xmission.com> <20070108223355.GI6167@stusta.de> <200701090014.42144.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701090014.42144.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 12:14:41AM +0100, Andi Kleen wrote:
> 
> > We just got a completely different bug reported that was confirmed to be 
> > caused by Andi's patch:
> >    AMD64/ATI : timer is running twice as fast as it should [1]
> 
> I have such a machine that showed this problem and when I wrote the patch I 
> tested it on it (and on a couple of others of course). No twice as fast on 
> my testing.
> 
> In fact there are two types of ATI machines: ones that have a BIOS workaround
> for the original Linux issue and ones that don't. Keeping both
> happy is not easy.
> 
> So I'm somewhat dubious on that. Where is that report?

Follow the link [1] in my email (and the bug is already assigned to 
you).

> > My whole point is that for 2.6.20, we can live with simply reverting 
> > Andi's commit.
> 
> I agree. It's more problematical than I expected. Reverting is 
> the best option right now.
> 
> -Andi

cu
Adrian

[1] http://bugzilla.kernel.org/show_bug.cgi?id=7789

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


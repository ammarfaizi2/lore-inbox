Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVLPPBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVLPPBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVLPPBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:01:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932323AbVLPPBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:01:01 -0500
Date: Fri, 16 Dec 2005 16:01:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216150102.GB23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <43A1DB18.4030307@wolfmountaingroup.com> <1134688488.12086.172.camel@mindpipe> <43A1E451.2090703@wolfmountaingroup.com> <1134689197.12086.176.camel@mindpipe> <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 09:39:56AM -0500, linux-os (Dick Johnson) wrote:
> 
> Throughout the past two years of 4k stack-wars, I never heard why
> such a small stack was needed (not wanted, needed). It seems that
> everybody "knows" that smaller is better and most everybody thinks
> that one page in ix86 land is "optimum". However I don't think
> anybody ever even tried to analyze what was better from a technical
> perspective. Instead it's been analyzed as religious dogma, i.e.,
> keep the stack small, it will prevent idiots from doing bad things.
>...

It seems you missed the discussion of this issue last month.

Arjan had a good list of all technical advantages of 4k stacks:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0511.2/0042.html

> Cheers,
> Dick Johnson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


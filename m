Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVHEMDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVHEMDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVHEMDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:03:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60680 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262998AbVHEMDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:03:16 -0400
Date: Fri, 5 Aug 2005 14:03:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bugme-admin@osdl.org
Subject: Re: kernel status, 4 Aug 2005
Message-ID: <20050805120312.GL4029@stusta.de>
References: <20050805020729.50146221.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805020729.50146221.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 02:07:29AM -0700, Andrew Morton wrote:
>...
> Open bugs:
> 
>   This is based on my reading of what's real and of what's worth
>   attending to.  Quite a few things get culled up-front.
> 
>   There are several emailed bug reports which are probably live bugs but
>   they have gone stale hence I have asked the reporters to raise bugzilla
>   reports, so more post-2.6.12 bugs will appear as the reporters retest
>   2.6.13-rc6.
> 
>   I really don't want to have to track bugs which aren't in bugzilla.  If
>   an emailed bug report comes in and we can address it within a few days
>   and a few emails then fine.  If that doesn't happen I'll be asking
>   reporters to open bugzilla reports.
> 
>   All bugs reported prior to the 2.6.12 release have been discarded. 


One thing to note is that this only says that such bugs are no longer on 
your radar. They are still in Bugzilla, and maintainers are still 
encouraged to review and fix them.


>   I'll henceforth track bugs across succeeding major release, so this list
>   will just grow.
> 
>   There are 60 bugs here.  They're almost all post-2.6.12 regressions. 
>   Longer-term we simply have to do better than this, else we'll stabilise
>   at a pretty buggy level.  No matter what process changes we make, the
>   bottom line is that developers/maintainers will need to spend more of
>   their time working with reporters on fixing bugs.
>...


You could track the bugs through Bugzilla.

An advantage would be that everyone can always see which bugs you are 
tracking.

One way would be to (ab)use bug severities
(e.g. severity >= high and number >= 4768).

Another way would be to add bug flags to Bugzilla in a way Mozilla uses 
them [1], IOW a field in the bugs that only you can set.


cu
Adrian

[1] https://bugzilla.mozilla.org/flag-help.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


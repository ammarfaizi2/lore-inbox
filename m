Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269729AbUJWBp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269729AbUJWBp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUJWBnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:43:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40197 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269759AbUJWBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:40:36 -0400
Date: Sat, 23 Oct 2004 03:40:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: espenfjo@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041023014004.GG22558@stusta.de>
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com> <20041022225703.GJ19761@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022225703.GJ19761@alpha.home.local>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 12:57:03AM +0200, Willy Tarreau wrote:
> On Fri, Oct 22, 2004 at 11:52:50PM +0200, Espen Fjellv?r Olsen wrote:
>...
> > A 2.7 should be created where all new experimental stuff is merged
> > into it, and where people could begin to think new again.
> 
> This could be true if the release cycle was shorter. But once 2.7 comes
> out, many developpers will only focus on their development and not on
> stabilizing 2.6 as much as today.

2.6.9 -> 2.6.10-rc1:
- 4 days
- > 15 MB patches

It's a bit optimistic to call this amount of change "stabilizing".

2.6 is corrently more a development kernel than a stable kernel.

The last bug I observed personally was the problem with suspending when 
using CONFIG_REGPARM=y together with Roland's waitid patch which was 
added in 2.6.9-rc2. If I'd used 2.6.9 with the same .config as 2.6.8.1, 
this was simple one more bug...

IMHO Andrew+Linus should open a short-living 2.7 tree soon and Andrew 
(or someone else) should maintain a 2.6 tree with less changes (like 
Marcelo did and does with 2.4).

> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755139AbWKVPXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbWKVPXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbWKVPX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:23:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63492 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755139AbWKVPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:23:29 -0500
Date: Wed, 22 Nov 2006 16:23:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061122152328.GI5200@stusta.de>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 09:33:37AM -0800, Linus Torvalds wrote:
>...
> I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
> broken.
> 
> Sane people use suspend-to-ram, and that's when you need the suspend and 
> resume debugging.
> 
> Software-suspend is silly. I want my machine back in three seconds, not 
> waiting for minutes..

It depends on what you are using STD for.  ;-)

It might be a bit off-topic for this thread, but I'm using STD for 
turning my PC off in the evening and getting it back in exactly the same 
state in the morning.

This might not have been the original purpose of suspend, but it works 
quite well, STR is obviously not an alternative, and it doesn't matter 
much whether it takes a minute.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


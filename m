Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWDEJCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWDEJCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWDEJCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:02:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:774 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751179AbWDEJCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:02:19 -0400
Date: Wed, 5 Apr 2006 11:02:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Samuelsson <sam@home.se>, linux-kernel@vger.kernel.org,
       mchehab@infradead.org, js@linuxtv.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [-mm patch] drivers/media/video/bt866.c: small fixes
Message-ID: <20060405090218.GA8673@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404163001.GO6529@stusta.de> <20060404203219.40fe6b4c.sam@home.se> <20060405004212.47312021.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405004212.47312021.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 12:42:12AM -0700, Andrew Morton wrote:
> Martin Samuelsson <sam@home.se> wrote:
> >
> > This should fix all things Andrew pointed out when I first submitted the 
> >  avs6eyes driver.
> 
> We still have all that #ifdef MODULE stuff at the end of bt866.c. 
> (Shouldn't it have module_init() and module_exit() handlers?)
>...

This is what my patch does.

Martin's patch does not include my patch, it is on top of it.

You should have seen a merge conflict when merging Martin's patch, and 
the reason is that you hadn't applied my patch before his patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


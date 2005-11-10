Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVKJRiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVKJRiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKJRiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:38:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59665 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751131AbVKJRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:38:24 -0500
Date: Thu, 10 Nov 2005 18:38:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
Message-ID: <20051110173822.GD5376@stusta.de>
References: <436FF51D.8080509@us.ibm.com> <436FF894.8090204@us.ibm.com> <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI> <4370F7AE.5090505@us.ibm.com> <20051110104211.GB5376@stusta.de> <43737D94.2060408@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43737D94.2060408@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 09:04:20AM -0800, Matthew Dobson wrote:
> Adrian Bunk wrote:
> > 
> >>Well, no, they aren't on the hot path.  I just figured since they are only
> >>ever called from one other function, why not inline them?  If the sentiment
> >>is that it's a BAD idea, I'll drop it.
> > 
> > 
> > And if there will one day be a second caller, noone will remember to 
> > remove the inline...
> 
> So are you suggesting that we don't mark these functions 'inline', or are
> you just pointing out that we'll need to drop the 'inline' if there is ever
> another caller?

I'd suggest to not mark them 'inline'.

> -Matt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWHXQsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWHXQsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWHXQsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:48:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751620AbWHXQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:48:10 -0400
Date: Thu, 24 Aug 2006 18:48:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824164808.GN19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:39:14PM +0200, Jan Engelhardt wrote:
> >> On Thu, 2006-08-24 at 17:29 +0200, Adrian Bunk wrote:
> >> >         bool "Enable the block layer" depends on EMBEDDED 
> >> 
> >> Please. no. CONFIG_EMBEDDED was a bad idea in the first place -- its
> >> sole purpose is to pander to Aunt Tillie.
> >
> >It's not for Aunt Tillie.
> >It's for an average system administrator who compiles his own kernel.
> >
> >CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
> >possible, and I really know what I'm doing" people.
> 
> Then that should be CONFIG_I_AM_AN_EXPERT (CONFIG_EXPERT), not 
> CONFIG_EMBEDDED.

It makes sense that there is one option only for additional space 
savings.

But you are right, we need a second option for not space related expert 
options.

I'll send a patch for this.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


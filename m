Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWHXP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWHXP6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWHXP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:58:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965069AbWHXP6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:58:16 -0400
Date: Thu, 24 Aug 2006 17:58:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824155814.GL19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156434274.3012.128.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:44:34PM +0100, David Woodhouse wrote:
> On Thu, 2006-08-24 at 17:29 +0200, Adrian Bunk wrote:
> >         bool "Enable the block layer" depends on EMBEDDED 
> 
> Please. no. CONFIG_EMBEDDED was a bad idea in the first place -- its
> sole purpose is to pander to Aunt Tillie.

It's not for Aunt Tillie.
It's for an average system administrator who compiles his own kernel.

CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
possible, and I really know what I'm doing" people.

There's no reason for getting linux-kernel swamped with
"my kernel doesn't boot" messages by people who accidentally disabled 
this option.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVKJSUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVKJSUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKJSUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:20:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32274 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750894AbVKJSUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:20:02 -0500
Date: Thu, 10 Nov 2005 19:20:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
Message-ID: <20051110182001.GF5376@stusta.de>
References: <436FF51D.8080509@us.ibm.com> <43737D94.2060408@us.ibm.com> <20051110173822.GD5376@stusta.de> <200511101904.23114.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511101904.23114.oliver@neukum.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 07:04:22PM +0100, Oliver Neukum wrote:
> Am Donnerstag, 10. November 2005 18:38 schrieb Adrian Bunk:
> > > So are you suggesting that we don't mark these functions 'inline', or are
> > > you just pointing out that we'll need to drop the 'inline' if there is ever
> > > another caller?
> > 
> > I'd suggest to not mark them 'inline'.
> 
> It seems you have found one more use for sparse. How about a tag
> like __single_inline that will cause a warning if a function having it
> is called from more than one place?

Why should such a function be manually marked "inline" at all?

If a static function is called exactly once it is the job of the 
compiler to inline the function.

> 	Regards
> 		Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


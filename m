Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWFGWvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWFGWvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWFGWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:51:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45071 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932456AbWFGWvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:51:10 -0400
Date: Thu, 8 Jun 2006 00:51:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jordi <mumismo@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Automatic bug hunting
Message-ID: <20060607225111.GV3955@stusta.de>
References: <200606080009.06089.raigengo@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606080009.06089.raigengo@yahoo.es>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 12:09:04AM +0200, Jordi wrote:
> 
> Related with the recent times _perceived_  increase in the number of bugs of 
> the Kernel. I have found the following website:
> http://scan.coverity.com/
> 
> They use automatic statis source code test for a number of projects including 
> the Linux kernel.
> 
> I've not registered so I don't know what kind of bugs have been found but it's 
> very unlikely that they have found "I don't have the hardware to fix this" 
> kind of bugs. They surely are clear bugs, similar to those found by the 
> automatic test for locking problems. 

"They surely are clear bugs" is wrong, the proof is the trivial fact 
that not less than 148 kernel issues have already been marked as FALSE 
inside the Coverity tracker.

> I think this is a good source to check before doing a stable release. Unlikely  
> human's bugs report, those report should be clear enought. We may aim for 
> being "coverity free" before each major version (check it before 2.6.17).

If you'd have followed linux-kernel for a while, you'd have seen how 
many patches have already been sent and merged for issues listed there.

You can set any aim you want, but since the vast majority of these 
issues are not regressions from 2.6.16 there's no reason delaying 2.6.17 
for it.

Even more considering that even many of the Coverity issues are often 
harmless issues like e.g. dead code.

> Jordi Polo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWJEQvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWJEQvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWJEQvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:51:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932181AbWJEQve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:51:34 -0400
Date: Thu, 5 Oct 2006 18:51:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: make-bogus-warnings-go-away tree [was: 2.6.18-mm3]
Message-ID: <20061005165132.GK16812@stusta.de>
References: <20061003001115.e898b8cb.akpm@osdl.org> <20061005083754.GA1060@elte.hu> <20061005163721.GJ16812@stusta.de> <4525367E.7080101@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4525367E.7080101@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 12:44:46PM -0400, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >What we'd need would be some -Wno-may-be-used-uninitialized gcc option 
> >that turns off the "may be may be used uninitialized" warnings but not 
> >the "is used uninitialized" warnings.
> >
> >This would:
> >- give us a way to silence these warnings
> >- allow people to see the warnings if they want to
> >- not increase the maintenance overhead
> 
> Some of those warnings do indicate real bugs.

Some of the -Wmissing-prototypes warnings do also indicate real bugs.

But although I'm working on cleaning up the -Wmissing-prototypes 
warnings for a year or two, I doubt you'd be happy if we'd enable 
-Wmissing-prototypes now...

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


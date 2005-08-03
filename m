Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVHCLUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVHCLUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVHCLUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:20:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15884 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262224AbVHCLUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:20:52 -0400
Date: Wed, 3 Aug 2005 13:20:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Coady <lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5 randconfig kernel build errors
Message-ID: <20050803112050.GL4029@stusta.de>
References: <lrque1drc20ev6o6441mn918e753r7vmki@4ax.com> <1651f199ie23tv14qv8jnnc53m97qdk1uh@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651f199ie23tv14qv8jnnc53m97qdk1uh@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 07:58:02PM +1000, Grant Coady wrote:
> On Tue, 02 Aug 2005 22:58:59 +1000, Grant Coady <lkml@dodo.com.au> wrote:
> 
> >Greetings,
> >
> >Preliminary results, better sample (some hundreds) in a day or so.
> 
> After 300 random builds, add one more error:
> drivers/acpi/osl.c:261: error: `AmlCode' undeclared (first use in this function)
> drivers/acpi/osl.c:61:10: empty file name in #include

Please exclude builds with CONFIG_STANDALONE=n.

And please don't send every new error you are finding to this list.
As I've already said generating the errors is the the easy part -
analyzing them is the real work.

It would be best if you would do this yourself and send specific bug 
reports (or even patches) for the problems you've find.

If you want to publish the errors you've found, send a pointer to a 
location where it is available _once_ and update the information there.

This is e.g. how Jan Dittmer is doing it with his very valuable cross 
compile site [1] - he doesn't send daily emails but if I want to know 
the information I can always find it there.

> Cheers,
> Grant.

cu
Adrian

[1] http://l4x.org/k/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


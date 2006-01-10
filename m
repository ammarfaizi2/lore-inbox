Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWAJQbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWAJQbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAJQbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:31:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9734 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932235AbWAJQbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:31:02 -0500
Date: Tue, 10 Jan 2006 17:31:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tim Tassonis <timtas@cubic.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-ID: <20060110163100.GM3911@stusta.de>
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de> <43C3B7C8.8000708@cubic.ch> <20060110141324.GJ3911@stusta.de> <43C3DBBE.3090001@cubic.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3DBBE.3090001@cubic.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 05:07:26PM +0100, Tim Tassonis wrote:
> Adrian Bunk wrote:
> >On Tue, Jan 10, 2006 at 02:34:00PM +0100, Tim Tassonis wrote:
> >>Like the OSS/Alsa or XFree3.x/XFree4.x situations.
> >
> >And OSS/ALSA is an example why this is not a good thing:
> >- OSS in the kernel is unmaintained
> 
> Because it is dead, yes...

And this is exactly what you predicted for one of the merged stacks.

>...
> >But if you have the possibility to choose which stack to use at the 
> >beginning (as in the wireless case), the only reasonable solution is to 
> >choose _one_ stack.
> 
> ... _if_ you have the possibility, yes. But you might end up having 
> chosen the wrong one. There is a reason why two stacks exist.

The decision was already in the past - there is one stack that is 
already merged.

The question is whether there is a different stack that is considered 
that much better that switching to this stack including converting all 
drivers is worth the effort.

In the short term, having different stacks with different features and 
deficites only creates confusion.

In the long term, different stacks in the kernel will be a maintenance 
nightmare.

> Tim

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


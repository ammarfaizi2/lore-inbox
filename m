Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWIZUOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWIZUOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWIZUOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:14:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27151 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964777AbWIZUOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:14:43 -0400
Date: Tue, 26 Sep 2006 22:14:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060926201437.GH4547@stusta.de>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925224500.GB2540@elf.ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 12:45:00AM +0200, Pavel Machek wrote:
>...
> solid)
> 	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
> 	time before that... these are driver problems...
>...

One point that seems to be a bit forgotten is that driver problems do 
actually matter a lot:

I for one do not care much whether I can abort suspending (I can always 
resume) or whether dancing penguins are displayed during suspending - 
but the fact that my saa7134 card only outputs the picture but no sound 
after resuming from suspend-to-disk is a real show-stopper for me.

> 									Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbSKSSyv>; Tue, 19 Nov 2002 13:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbSKSSyv>; Tue, 19 Nov 2002 13:54:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39912 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267218AbSKSSyt>; Tue, 19 Nov 2002 13:54:49 -0500
Date: Tue, 19 Nov 2002 20:01:47 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Dead & Dying interfaces
Message-ID: <20021119190146.GX11952@fs.tum.de>
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk> <20021118175535.GD15318@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118175535.GD15318@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 05:55:35PM +0000, Dave Jones wrote:
> On Fri, Nov 15, 2002 at 06:47:25PM +0000, Matthew Wilcox wrote:
> 
>  > This list is a combination of interfaces which have gone during 2.5 and
>  > interfaces that should go during 2.7.  Think of it as a `updating your
>  > driver/filesystem to sane code' guide.
> 
> Adding printk (KERN_DEBUG "Usage of check_region() is deprecated");
> to such interfaces may be an idea. For some of them, however it
> is probably a bad idea if the logs get flooded with zillions of warnings
> each boot.  Maybe just for the "We really should purge this crap next
> time" functions ?

What about a #warning? With a #warning everyone compiling this code sees
that there's something that needs updating but it doesn't flood the logs
of users (#warning was already used for linux/malloc.h in 2.4).

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


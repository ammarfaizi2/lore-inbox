Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbVBETjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbVBETjl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbVBETjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:39:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2576 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269410AbVBETiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:38:15 -0500
Date: Sat, 5 Feb 2005 20:38:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
Message-ID: <20050205193813.GG3129@stusta.de>
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de> <41FCFED4.1070301@tiscali.de> <ctrtbe$570$1@terminus.zytor.com> <20050205135026.GC3129@stusta.de> <42051460.9060208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42051460.9060208@zytor.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 10:45:52AM -0800, H. Peter Anvin wrote:
> Adrian Bunk wrote:
> >
> >As I already said in this thread:
> >  The currently used file for gcc 4 is compiler-gcc+.h, not
> >  compiler-gcc3.h .
> >
> >And the current setup is to have one file for every major number of gcc.
> >I have no strong opinion whether this approach or the approach of one 
> >file for all gcc versions is better - but with the current approach, 
> >everything else than a separate file for gcc 4 wasn't logical.
> 
> Yes it is.  It's perfectly logical: gcc+ contains the "going forward" 
> version, and until it supports some feature that isn't in all versions 
> of gcc4, it's the right thing to do.
>...

It doesn't seem to be logical for everyone whether compiler-gcc+.h or 
compiler-gcc3.h is used for gcc 4.0 ...

Perhaps compiler-gcc+.h (which wasn't always updated when 
compiler-gcc3.h was updated) should be removed?

> 	-hpa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVBENvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVBENvD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 08:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbVBENvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 08:51:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44043 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263148AbVBENu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 08:50:28 -0500
Date: Sat, 5 Feb 2005 14:50:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
Message-ID: <20050205135026.GC3129@stusta.de>
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de> <41FCFED4.1070301@tiscali.de> <ctrtbe$570$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ctrtbe$570$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 01:04:46AM +0000, H. Peter Anvin wrote:
> Followup to:  <41FCFED4.1070301@tiscali.de>
> By author:    Matthias-Christian Ott <matthias.christian@tiscali.de>
> In newsgroup: linux.dev.kernel
> > 
> > Hi!
> > But maybe gcc 4 will get different later, so I think this patch makes sense.
> > 
> 
> No, it doesn't.  You fork when you have a reason.  Eager forking is
> *BAD*.

As I already said in this thread:
  The currently used file for gcc 4 is compiler-gcc+.h, not
  compiler-gcc3.h .

And the current setup is to have one file for every major number of gcc.
I have no strong opinion whether this approach or the approach of one 
file for all gcc versions is better - but with the current approach, 
everything else than a separate file for gcc 4 wasn't logical.

I can offer the following choices:
- please apply this compiler-gcc4.h patch
- let me send a patch merging all compiler-gcc*.h files into one
  compiler-gcc.h file
- let me send a patch merging all compiler-gcc*.h files back into 
  compiler.h

> 	-hpa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


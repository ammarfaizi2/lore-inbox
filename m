Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVIDTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVIDTjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVIDTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:39:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28688 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750979AbVIDTjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:39:31 -0400
Date: Sun, 4 Sep 2005 21:39:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050904193929.GB3741@stusta.de>
References: <20050902003915.GI3657@stusta.de> <1125805704.14032.71.camel@mindpipe> <431AA3E2.8020909@stesmi.com> <1125822185.14032.75.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125822185.14032.75.camel@mindpipe>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 04:23:04AM -0400, Lee Revell wrote:
> On Sun, 2005-09-04 at 09:36 +0200, Stefan Smietanowski wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Lee Revell wrote:
> > > On Fri, 2005-09-02 at 02:39 +0200, Adrian Bunk wrote:
> > > 
> > >>4Kb kernel stacks are the future on i386, and it seems the problems it
> > >>initially caused are now sorted out.
> > >>
> > >>Does anyone knows about any currently unsolved problems?
> > > 
> > > 
> > > ndiswrapper
> > 
> > While I agree ndiswrapper has a use ... I don't think we should
> > base kernel development upon messing with something that is designed
> > to run a windows driver in linux ...
> 
> Good point, but I don't think we should needlessly render people's
> hardware inoperable either.

The NdisWrapper FAQ already tells you that you need a patch for some of 
the binary-only Windows drivers that require more than 8kB stacks.

And the fact that NdisWrapper is mostly working hinders the development 
of open source drivers for this hardware.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


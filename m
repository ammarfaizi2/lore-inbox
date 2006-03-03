Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWCCRzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWCCRzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWCCRzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:55:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4619 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030262AbWCCRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:55:43 -0500
Date: Fri, 3 Mar 2006 18:55:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060303175542.GT9295@stusta.de>
References: <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com> <20060302203245.GD9295@stusta.de> <1141335521.3582.14.camel@Rainsong.home> <20060302214423.GI9295@stusta.de> <1141361097.3582.40.camel@Rainsong.home> <20060303114642.GO9295@stusta.de> <1141397326.3582.57.camel@Rainsong.home> <20060303151026.GQ9295@stusta.de> <1141408251.11092.4.camel@Rainsong.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141408251.11092.4.camel@Rainsong.home>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 12:50:51PM -0500, James C. Georgas wrote:
> On Fri, 2006-03-03 at 16:10 +0100, Adrian Bunk wrote:
> > On Fri, Mar 03, 2006 at 09:48:46AM -0500, James C. Georgas wrote:
> > > 
> > > Ok, if I understand you correctly now, there is a function defined in
> > > another part of the kernel, which is _called_ by AF_UNIX, and it is for
> > > this function that the other part of the kernel must export a symbol?
> > > 
> > > But you only need to do this so that modules can use the function,
> > > because if, instead, the driver is built in, then the function is
> > > directly in scope, and can be called explicitly?
> > 
> > Correct.
> 
> Ok, I understand.
> 
> What are the exported symbols, and where are they defined?
> 
> I read the post you linked to earlier, but I got nothing when I grepped
> for "get_max_files", which was mentioned.

You must look at the latest -mm.

> James C. Georgas <jgeorgas@rogers.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


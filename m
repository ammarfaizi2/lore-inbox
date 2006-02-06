Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWBFTRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWBFTRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWBFTRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:17:36 -0500
Received: from [81.222.97.19] ([81.222.97.19]:10907 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S932299AbWBFTRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:17:35 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Joshua Kugler <joshua.kugler@uaf.edu>
Subject: Re: Linux drivers management
Date: Mon, 6 Feb 2006 22:17:19 +0300
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
References: <1139250712.20009.20.camel@rousalka.dyndns.org> <200602061002.27477.joshua.kugler@uaf.edu>
In-Reply-To: <200602061002.27477.joshua.kugler@uaf.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062217.19697.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> 
> I heartily agree with this!!
> 
> I use two products that use out-of-tree drivers.  VMWare and NVidia cards.  
> Fortunately, the build processes for both are rather painless, but there have 
> been times when it has *not* been, and it was extremely frustrating.  I 
> remember when VMWare was not doing a good job of supporting 2.6 kernels and I 
> spent the better part of two days trying to track down a solution.  I finally 
> did, but it was a third party, non-VMWare, patch to the VMWare code that 
> fixed it so it would compile and run.  That's not what I consider convenience 
> for the non-technical user.  A non-technical user would not have been able to 
> do what I did, especially when they just want their software to work.
And then think, why do you need to _build_ drivers in the first place. 
Wouldn't it be better to have one vmware.ko which insmod's with all 2.6 versions , from 2.6.0 to 2.6.16-rc2 , 
and throw "upgrade pain" away completely ? 
> 
> I want to install my machine and have everything work.  Don't make me chase 
> all over the net trying to find a driver for my hardware.  If it's a network 
All over the net ? Again, you're proving stable API/ABI supporters nicely. 
If kernel has stable ABI, basic/default driver is included on installation CD, and all you need to do 
is to launch ./install-linux.sh from CD in your shell or click OK and enter your root password in GUI box.
Newer/better driver - just go to device manufacturer's website, download installation package and install this driver. 
Without rebuilding. 
> (i.e. ethernet device) the driver had *better* be in the tree.  Trying to 
> download the driver to another computer, transferring, etc, is enough to make 
> me find another brand of network card.
And what to do if you've bought new hardware, installed it and _voila_ - NO IN-TREE DRIVER exists ?
Do you want every Linux user  going for shopping to nearest WalMart carry full linux hardware compatibility list printed out ?
Or intree driver list ?
> Latest kernel == latest driver.  No need for me to try to keep all my drivers 
> up to date.
Wrong. Latest kernel is latest kernel. Latest driver is latest driver. They are different entities, and don't mix'em.
> 
> I sometimes delay kernel updates because I don't want to mess with updating my 
> NVidia and VMWare drivers.  This is *not* good for security.
So who to blame ? Maybe, just look at those who don't want stable driver API ?
> So I did.  Please put your driver in the tree.  It will be better for all 
> concerned.
Please, don't force your preferences over others'
-- 
Managing your Territory since the dawn of times ...

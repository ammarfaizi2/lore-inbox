Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUHCNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUHCNNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHCNNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:13:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25554 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266357AbUHCNNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:13:44 -0400
Date: Tue, 3 Aug 2004 15:13:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
Message-ID: <20040803131339.GB2746@fs.tum.de>
References: <20040802225951.GR2746@fs.tum.de> <20040802162846.3929e463.akpm@osdl.org> <20040803004509.GW2746@fs.tum.de> <1091490958.1647.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091490958.1647.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 12:56:01AM +0100, Alan Cox wrote:
> On Maw, 2004-08-03 at 01:45, Adrian Bunk wrote:
> > OTOH, at least XFS is known to have problems with 4kb stacks - and you 
> > don't want such problems to occur in production environments.
> 
> So put && !4KSTACKS in the XFS configuration ?

I originally did this additionally (including moving 4KSTACKS
above  XFS).

But independent of the XFS problem, 4kb stacks currently risk additional 
breakage without real benefits for most users.

That sounds like a perfect place for using EXPERIMENTAL to me.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


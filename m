Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVCCWt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVCCWt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVCCWQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:16:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29962 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262678AbVCCWPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:15:12 -0500
Date: Thu, 3 Mar 2005 23:15:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303221503.GS4608@stusta.de>
References: <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <20050303170759.GA17742@ti64.telemetry-investments.com> <20050303193358.GA29371@redhat.com> <20050303203808.GA10408@ti64.telemetry-investments.com> <42278194.7020409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42278194.7020409@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 04:28:52PM -0500, Jeff Garzik wrote:
> Bill Rugolsky Jr. wrote:
> >I've watched you periodically announce "hey, I'm doing an update for
> >FC3/FC2, please test" on the mail list, and a handful of people go test.
> >If we could convince many of the the less risk-averse but lazy users to
> >grab kernels automatically from updates/3/testing/ or updates/3/unstable/
> >as part of "yum update", and have a way to manage the plethora of (even
> >daily) kernel updates by removing old unused kernels, then we'd only
> >have to convince them *once* to set up their YUM repos, and then get them
> >to poweroff or reboot [or use a Xen domain] occasionally. :-)
> 
> 
> Tangent:  I would like to see requests-for-testing for FC kernels on LKML.
> 
> If people announce -ac/-as/-aa/-ck/etc. kernels on LKML, why not distro 
> kernels?

Debian unstable currently contains only for kernel 2.6.8 (which is AFAIK 
still the main kernel in Debian unstable although there are also 2.6.10 
sources and 2.6.10 kernel images on some architectures) for eight 
different architectures - many of them containing or depending on their 
own patches.

How big is the value of a

  New 2.6.8-5 s390 kernel images for Debian unstable - please test!

or a

  New 2.2.25-4 atari kernel images for Debian unstable - please test!

on LKML?


Note that there are currently 42 (what a number ;-) ) different packages 
that build 2.2, 2.4 and 2.6 kernels images in Debian unstable plus the 
packages that build the kernel images for the 11 architectures in Debian 
stable.
Considering how many other distributions exist, this generates a serious 
amount of extra traffic on LKML if a security hole gets fixed that 
affects many kernel versions...

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


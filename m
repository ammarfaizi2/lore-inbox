Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUGTUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUGTUun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGTUun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:50:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50420 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266227AbUGTUuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:50:39 -0400
Date: Tue, 20 Jul 2004 22:50:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, nathans@sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040720205030.GO14733@fs.tum.de>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040720204238.GA3051@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720204238.GA3051@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 01:42:38PM -0700, Chris Wedgwood wrote:
> On Tue, Jul 20, 2004 at 09:50:12PM +0200, Adrian Bunk wrote:
> 
> > 1. let 4KSTACKS depend on EXPERIMENTAL
> 
> i don't like this change, despite what i might have claimed earlier :)
> 
> the reason i say this is if XFS blows up with 4K stacks then it
> probably can with 8K stacks but it will be much harder, so it's not
> really fixing anything but just papering over the problem
>...

2.6 is a stable kernel series used in production environments.

The correct solution is to fix XFS (and other problems with 4kb stacks   
if they occur), and my patch is only a short-term workaround.

4KSTACKS=n is simply the better tested case, and 4KSTACKS=y uncovers 
some issues you might not want to see in production environments.

>   --cw

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


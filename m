Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWAFWxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWAFWxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWAFWxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:53:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32527 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964947AbWAFWxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:53:32 -0500
Date: Fri, 6 Jan 2006 23:53:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20060106225330.GB3774@stusta.de>
References: <20060106173547.GR12131@stusta.de> <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com> <20060106180626.GV12131@stusta.de> <Pine.LNX.4.62.0601061305480.334@qynat.qvtvafvgr.pbz> <20060106223702.GA3774@stusta.de> <Pine.LNX.4.62.0601061438020.431@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601061438020.431@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 02:39:34PM -0800, David Lang wrote:
> On Fri, 6 Jan 2006, Adrian Bunk wrote:
> 
> >
> >On Fri, Jan 06, 2006 at 01:11:17PM -0800, David Lang wrote:
> >>On Fri, 6 Jan 2006, Adrian Bunk wrote:
> >>...
> >>>>- Being able to easily enable it in menuconfig, then browse through
> >>>>the menus to look for something matching your hardware is nice, even
> >>>>if that something is marked BROKEN at least you've then found a place
> >>>>to start working on. A lot simpler than digging through directories.
> >>>
> >>>Our menus are mostly made for _users_.
> >>
> >>true, but do you really want to raise the barrier for users to test
> >>things? or do you intend to have a bunch of patches that remove BROKEN for
> >>a config option so that people can test them during the -rc and then add
> >>it back for them all before a real release?
> >
> >If an option is untested it's EXPERIMENTAL.
> >If it's broken it's BROKEN.
> >
> >If an option is marked as BROKEN but works fine for you please send a
> >bug report.
> 
> my point is that if someone sends a patch that they think will fix 
> something, nobody will be able to test that patch unless they are willing 
> to edit their kconfig file unless the patch also marks it unbroken before 
> anyone else has tested it.

Kernel developers usually aren't _that_ dumb:
The patch that fixes the driver simply removes the dependency on BROKEN.

> David Lang

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


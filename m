Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWCFXCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWCFXCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbWCFXCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:02:37 -0500
Received: from mail.suse.de ([195.135.220.2]:20698 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751932AbWCFXCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:02:37 -0500
Date: Tue, 7 Mar 2006 00:02:35 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060306230235.GA6113@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de> <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org> <20060305204231.GA22002@suse.de> <17419.23860.883220.80199@cargo.ozlabs.ibm.com> <20060306164818.GA2523@suse.de> <20060306222000.GA5903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060306222000.GA5903@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 06, Olaf Hering wrote:

>  On Mon, Mar 06, Olaf Hering wrote:
> 
> >  On Mon, Mar 06, Paul Mackeras wrote:
> > 
> > > There are also commits from Ben H that change the way we parse
> > > addresses from the OF device tree.  If you can bisect a bit further
> > > that would be good, although you may strike problems between the 401d
> > > and 6237 commits I mentioned above.
> > 
> > What I have right now is this, which got me in a non-compiling state.
> > I will pick the udbg stuff and apply the relevant changes to -git5.

I tried with CONFIG_BOOTX_TEXT disabled. same result. This is the list
of patches I used on top of 2.6.15:

patches.kernel.org/patch-2.6.15-git5
patches.suse/get_cramfs_inode-revert.patch
patches.suse/suse-ppc-legacy-io.patch
patches.arch/0022-powerpc-incorrect-rmo_top-handling-in-prom_init.txt
patches.suse/9100b205fdc70b300894954ebebbf2709c5ed525.patch
patches.suse/3d1229d6ae92ed1994f4411b8493327ef8f4b76f.patch
patches.suse/d1405b869850982f05c7ec0d3f137ca27588192f.patch
patches.suse/463ce0e103f419f51b1769111e73fe8bb305d0ec.patch

patches.suse/51d3082fe6e55aecfa17113dbe98077c749f724c.patch
patches.suse/31df1678d7732b94178a6e457ed6666e4431212f.patch
patches.suse/8dacaedf04467e32c50148751a96150e73323cdc.patch
patches.suse/52020d2bda9fe447bb50674a2e39e4064b6a10b5.patch


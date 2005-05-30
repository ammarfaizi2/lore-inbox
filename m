Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVE3V5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVE3V5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVE3V5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:57:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261779AbVE3V5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:57:35 -0400
Date: Mon, 30 May 2005 23:57:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ide/: possible cleanups
Message-ID: <20050530215733.GB3627@stusta.de>
References: <20050530205631.GP10441@stusta.de> <1117489476.5194.6.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117489476.5194.6.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 07:44:36AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2005-05-30 at 22:56 +0200, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - pci/cy82c693.c: make a needlessly global function static
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - ide-taskfile.c: do_rw_taskfile
> >   - ide-iops.c: default_hwif_iops
> >   - ide-iops.c: default_hwif_transport
> >   - ide-iops.c: wait_for_ready
> 
> Are we sure we want to do that ? That would mean never having IDE host
> controller drivers as modules...
> 
> I was thinking about toying with that again for pmac one of these
> days ...
> 
> It may be worth, however, to rename those exported symbols to ide_*

My patch only removes the EXPORT_SYMBOL's.

It's always trivial to re-add them when you need them.

> Ben.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


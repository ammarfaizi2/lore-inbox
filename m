Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWDDR3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWDDR3P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDDR3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:29:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45838 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750725AbWDDR3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:29:15 -0400
Date: Tue, 4 Apr 2006 19:29:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Andrew Morton <akpm@osdl.org>, NeilBrown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] [-mm patch] fs/nfsd/nfs4state.c: make a struct static
Message-ID: <20060404172913.GT6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404163010.GQ6529@stusta.de> <20060404165045.GD17709@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404165045.GD17709@fieldses.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 12:50:45PM -0400, J. Bruce Fields wrote:
> On Tue, Apr 04, 2006 at 06:30:10PM +0200, Adrian Bunk wrote:
> > On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.16-mm2:
> > >...
> > > +knfsd-locks-flag-nfsv4-owned-locks.patch
> > >...
> > >  knfsd updates.
> > >...
> > 
> > This patch makes the needlessly global struct nfsd_posix_mng_ops static.
> 
> Whoops, thanks, looks good.
> 
> Do you have a script to look for patches that add non-statics?

I diff the output of "make namespacecheck" with the output from the 
-mm kernel before.

> --b.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDDQu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDDQu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDDQu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:50:56 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37096 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750755AbWDDQuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:50:55 -0400
Date: Tue, 4 Apr 2006 12:50:45 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, NeilBrown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] [-mm patch] fs/nfsd/nfs4state.c: make a struct static
Message-ID: <20060404165045.GD17709@fieldses.org>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404163010.GQ6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404163010.GQ6529@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 06:30:10PM +0200, Adrian Bunk wrote:
> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-mm2:
> >...
> > +knfsd-locks-flag-nfsv4-owned-locks.patch
> >...
> >  knfsd updates.
> >...
> 
> This patch makes the needlessly global struct nfsd_posix_mng_ops static.

Whoops, thanks, looks good.

Do you have a script to look for patches that add non-statics?

--b.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1751253AbXAPV3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXAPV3k (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXAPV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:29:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3604 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751253AbXAPV3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:29:39 -0500
Date: Tue, 16 Jan 2007 22:29:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Wendy Cheng <wcheng@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com,
       cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] [-mm patch] make gfs2_change_nlink_i() static
Message-ID: <20070116212942.GH3465@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070113095640.GK7469@stusta.de> <45AD3DCF.6000604@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AD3DCF.6000604@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 04:04:15PM -0500, Wendy Cheng wrote:
> Adrian Bunk wrote:
> >On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> >  
> >>...
> >>Changes since 2.6.20-rc3-mm1:
> >>...
> >> git-gfs2-nmw.patch
> >>...
> >> git trees
> >>...
> >>    
> >
> >
> >This patch makes the needlessly globlal gfs2_change_nlink_i() static.
> >  
> We will probably need to call this routine from other files in our next 
> round of code check-in.

You can always make it global again when you use it from another file.

> -- Wendy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


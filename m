Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCCA10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCCA10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVCCAYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:24:44 -0500
Received: from ozlabs.org ([203.10.76.45]:35534 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261329AbVCCAXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:23:21 -0500
Date: Thu, 3 Mar 2005 11:20:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
Message-ID: <20050303002036.GA22835@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu> <20050302123123.3d528d05.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302123123.3d528d05.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 12:31:23PM -0800, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Do you have any objections to merging FUSE in mainline kernel?
> 
> I was planning on sending FUSE into Linus in a week or two.  That and
> cpusets are the notable features which are 2.6.12 candidates.
> 
> - crashdump seems permanently not-quite-ready
> 
> - perfctr works fine, but is rather deadlocked because it is
>   similar-to-but-different-from ia64's perfmon, and might not be suitable
>   for ppc64 (although things have gone quiet on the latter front).

Not to mention that the ABI is still changing with each release...

> - nfsacl should be OK for 2.6.12 if Trond is OK with it.
> 
> - cachefs is a bit stuck because it's a ton of complex code and afs is
>   the only user of it.  Wiring it up to NFS would help.
> 
> - dm multipath is OK for 2.6.12
> 
> - reiser4 is less clear.  Once all the review comments have been addressed
>   and we start seeing a bit of vendor pull for it, maybe.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

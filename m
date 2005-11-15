Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVKOI50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVKOI50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKOI50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:57:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751390AbVKOI5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:57:24 -0500
Date: Tue, 15 Nov 2005 03:57:18 -0500
From: Jeff Garzik <jgarzik@redhat.com>
To: Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Linux-cachefs] Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-ID: <20051115085718.GA15464@devserv.devel.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> <20051114150347.1188499e.akpm@osdl.org> <1132010253.8802.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132010253.8802.20.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 06:17:33PM -0500, Trond Myklebust wrote:
> On Mon, 2005-11-14 at 15:03 -0800, Andrew Morton wrote:
> 
> > I think we need an NFS implementation and some numbers which make it
> > interesting.  Or at least, some AFS numbers, some explanation as to why
> > they can be extrapolated to NFS and some degree of interest from the NFS
> > guys.   Ditto CIFS.
> 
> There is a lot of interest from the HPC community for this sort of thing
> on NFS. Basically, it will help server scalability for projects that
> have large numbers of read-only files accessed by large numbers of
> clients.
> 
> AFAIK, Steve Dickson (steved@redhat.com) is working on the NFS hooks for
> FS-Cache.

Well, I'm not in the HPC community, but I have a lot of interest in seeing
cachefs + nfs working in the upstream kernel.

	Jeff, misses cachefs from the Solaris days




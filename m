Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVKRWH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVKRWH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVKRWH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:07:56 -0500
Received: from kalmia.hozed.org ([209.234.73.41]:7368 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S1750732AbVKRWHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:07:55 -0500
Date: Fri, 18 Nov 2005 16:07:53 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Linux-cachefs] Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-ID: <20051118220752.GX3275@kalmia.hozed.org>
References: <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> <20051114150347.1188499e.akpm@osdl.org> <1132010253.8802.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1132010253.8802.20.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
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

I'm currently running a root filesystem for a cluster using the OpenAFS 
client for precisely this reason.

And in regards to (other) comments about code size, if you think this is big,
take a look at the OpenAFS kernel module.

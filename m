Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263305AbVGAMIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbVGAMIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbVGAMIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:08:30 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:59574 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263305AbVGAMI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:08:27 -0400
Date: Fri, 1 Jul 2005 14:08:26 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-ID: <20050701120826.GC5218@janus>
References: <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org> <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org> <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org> <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 12:11:53PM +0200, Miklos Szeredi wrote:
> > > Userspace can tell the kernel, how long a dentry should be valid.  I
> > > don't think the NFS protocol provides this. Same holds for the inode
> > > attributes.
> > 
> > Why is that needed?
> 
> Because, I can well imagine a synthetic filesystem, where file
> data/metadata change aribitrarily.  In this case the timeout heuristic
> in NFS is not useful.
> 
> In fact with NFS it's often a PITA, that it doesn't want to refresh a
> file's data/metatata, which I _know_ has changed on the server.

This NFS issue is on my radar for years already. I have a patch which
is practical but a bit disgusting. IMHO it's orthogonal to FUSE.

-- 
Frank

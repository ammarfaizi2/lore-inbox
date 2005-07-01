Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263342AbVGANve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbVGANve (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbVGANvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:51:33 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:64950 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263344AbVGANvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:51:32 -0400
Date: Fri, 1 Jul 2005 15:51:31 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-ID: <20050701135131.GB5805@janus>
References: <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org> <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org> <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org> <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu> <20050701042955.39bf46ef.akpm@osdl.org> <1120222434.23346.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120222434.23346.16.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 01:53:54PM +0100, Anton Altaparmakov wrote:
> On Fri, 2005-07-01 at 04:29 -0700, Andrew Morton wrote:
> > Sorry, but I'm not buying it.  I still don't see a solid reason why all
> > this could not be done with nfs/v9fs, some kernel tweaks and the rest in
> > userspace.  It would take some effort, but that effort would end up
> > strengthening existing kernel capabilities rather than adding brand new
> > things, which is good.
> 
> Also can the NFS approach provide me with different content depending on
> the uid of the accessing process?  With FUSE that is easy as pie.  Even
> easier than that actually...

unfsd can that I believe. However, FUSE and user space NFSd are complementary.
For every NFS solution one still needs to do the mounting as root. FUSE
addresses the client side: it can implement a user space NFS client.

-- 
Frank

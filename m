Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319267AbSHNTJn>; Wed, 14 Aug 2002 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319268AbSHNTJm>; Wed, 14 Aug 2002 15:09:42 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:14527 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319267AbSHNTJm>; Wed, 14 Aug 2002 15:09:42 -0400
Date: Wed, 14 Aug 2002 15:13:27 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@mspacman.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: Re: patch 01/38: switches in fs/Config.in, fs/Config.help
Message-ID: <Pine.SOL.4.44.0208141507050.10938-100000@mspacman.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> " " == Christoph Hellwig <hch@infradead.org> writes:

     > On Tue, Aug 13, 2002 at 06:55:35PM -0400, Kendrick M. Smith
     > wrote:
    >> This patch defines new switches in fs/Config.in -
    >> CONFIG_NFS_V4: enables nfsv4 client CONFIG_NFSD_V4: enables
    >> nfsv4 server CONFIG_SUNRPC_GSSD_CLNT: enables in-kernel client
    >> for GSSD

     > This should be the last patch after the code got in..

I agree, patch 1/38 should be renumbered to 38/38, and everything else
shifted back by one.  If I have to repost the patchset (e.g. after rediff
to 2.5.32), I'll be sure to do this.

In the meantime, patch 1/38 does not conflict with any of the others;
the patches can be applied cleanly in the order
  2,3,4,....,38, 1
Maybe we can just consider this to be the patch ordering for purposes of
deciding which to apply to the 2.5.31 tree?  This way I won't have to
repost 200K of patches before 2.5.32 comes out...

Thanks,
 Kendrick


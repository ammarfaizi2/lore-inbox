Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263737AbSJHUhg>; Tue, 8 Oct 2002 16:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263751AbSJHUhb>; Tue, 8 Oct 2002 16:37:31 -0400
Received: from pc-62-31-74-104-ed.blueyonder.co.uk ([62.31.74.104]:42627 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S263737AbSJHUgI>; Tue, 8 Oct 2002 16:36:08 -0400
Date: Tue, 8 Oct 2002 21:41:43 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008214143.O2717@redhat.com>
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org> <200210082114.00576.agruen@suse.de> <20021008202038.A15692@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008202038.A15692@infradead.org>; from hch@infradead.org on Tue, Oct 08, 2002 at 08:20:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 08, 2002 at 08:20:38PM +0100, Christoph Hellwig wrote:
> On Tue, Oct 08, 2002 at 09:14:00PM +0200, Andreas Gruenbacher wrote:
> > Users might just fill up all xattr space leaving no space for ACLs (or 
> > similar). If user xattrs are disabled this can no longer occur, so some 
> > administrators might be happy to have a choice.
> 
> Umm, that's why we have quota..

It's the per-inode extended attribute space that's at risk here,
quotas don't help.

--Stephen

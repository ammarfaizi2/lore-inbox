Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271182AbUJVLIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271182AbUJVLIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbUJVLIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:08:50 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:3339 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271182AbUJVLIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:08:46 -0400
Date: Fri, 22 Oct 2004 12:08:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041022110846.GA17866@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org> <20041022103910.GB17526@infradead.org> <20041022035400.28131d76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022035400.28131d76.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:54:00AM -0700, Andrew Morton wrote:
> > Your tree also has various rejected core changes for it still.
> 
> Which were they?

reiser4-aliased-dir.patch
reiser4-allow-drop_inode-implementation.patch
reiser4-export-inode_lock.patch
reiser4-kobject-umount-race.patch
reiser4-unstatic-kswapd.patch


I'm not completely sure what problems the following one could
cause (or rather which problems of the scheme it's needed for
it doesn't solve):

reiser4-reget-page-mapping.patch

> > > +hfs-export-type-creator-via-xattr.patch
> > 
> > I haven't heard an answer on the comments on this on on -fsdevel yet..
> 
> To use the generic xattr code?  Yes, we're waiting to hear back on that.

I'm more concerned about the lacking xattr name prefix as that's a
published API.


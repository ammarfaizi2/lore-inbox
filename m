Return-Path: <linux-kernel-owner+w=401wt.eu-S932736AbXARWzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbXARWzc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbXARWzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:55:32 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50685 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932729AbXARWzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:55:31 -0500
Date: Thu, 18 Jan 2007 14:54:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, aia21@cam.ac.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: NTFS
Message-Id: <20070118145439.b8d84d6b.akpm@osdl.org>
In-Reply-To: <20070118223813.GA6589@infradead.org>
References: <1169115951.5408.10.camel@imp.csi.cam.ac.uk>
	<20070118222243.GA14047@infradead.org>
	<20070118143506.4d007aad.akpm@osdl.org>
	<20070118223813.GA6589@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 18 Jan 2007 22:38:13 +0000 Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Jan 18, 2007 at 02:35:06PM -0800, Andrew Morton wrote:
> > > Cool.  That means ->put_inode is gone in -mm.  Andrew, what are the
> > > plans for sending the patches to make the ext2 preallocation work
> > > like ext3 to Linus?  
> > 
> > Cautious.  I'm not sure that we ever want to merge them, really - ext2 is
> > more a reference filesystem than a real one nowadays, and making it more
> > complex detracts from that.
> 
> The again while the old preallocation code might be simpler it's also utterly
> braindead and we need to make sure no one is going to copy this :)

Good point ;)

Return-Path: <linux-kernel-owner+w=401wt.eu-S932663AbXARWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXARWiQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXARWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:38:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49529 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbXARWiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:38:15 -0500
Date: Thu, 18 Jan 2007 22:38:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, aia21@cam.ac.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: NTFS
Message-ID: <20070118223813.GA6589@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, aia21@cam.ac.uk, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <1169115951.5408.10.camel@imp.csi.cam.ac.uk> <20070118222243.GA14047@infradead.org> <20070118143506.4d007aad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118143506.4d007aad.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 02:35:06PM -0800, Andrew Morton wrote:
> > Cool.  That means ->put_inode is gone in -mm.  Andrew, what are the
> > plans for sending the patches to make the ext2 preallocation work
> > like ext3 to Linus?  
> 
> Cautious.  I'm not sure that we ever want to merge them, really - ext2 is
> more a reference filesystem than a real one nowadays, and making it more
> complex detracts from that.

The again while the old preallocation code might be simpler it's also utterly
braindead and we need to make sure no one is going to copy this :)

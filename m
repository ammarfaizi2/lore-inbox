Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWCVKZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWCVKZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWCVKZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:25:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751198AbWCVKZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:25:26 -0500
Date: Wed, 22 Mar 2006 10:25:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
Message-ID: <20060322102522.GA7025@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
References: <1142961077.7987.14.camel@lade.trondhjem.org> <20060321174634.GA15827@infradead.org> <1142967482.7987.83.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142967482.7987.83.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 01:58:01PM -0500, Trond Myklebust wrote:
> Could you, BTW, please post these pending patches? They are clearly not
> in -mm, since these patches have been there for some time without
> conflicting with anything else. The only references I could find were to
> the following thread:
> 
>    http://thread.gmane.org/gmane.linux.file-systems/7748
> 
> which basically just adds a BUG() if you call NFS O_DIRECT with a
> multi-segment iovec.

Yes, that's the latest public version.  and nfs is one of the last missing
items.


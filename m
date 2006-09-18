Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWIRTLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWIRTLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWIRTLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:11:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751654AbWIRTLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:11:20 -0400
Date: Mon, 18 Sep 2006 20:10:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, trond.myklebust@fys.uio.no,
       hch@infradead.org, torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       tburke@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: FS-Cache patches
Message-ID: <20060918191050.GA20392@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, Jeff Garzik <jeff@garzik.org>,
	trond.myklebust@fys.uio.no, torvalds@osdl.org, akpm@osdl.org,
	steved@redhat.com, tburke@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
References: <44C9D0FE.9090004@garzik.org> <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com> <20397.1157649444@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20397.1157649444@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 06:17:24PM +0100, David Howells wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > I'm really looking forward to seeing this in the upstream kernel... thanks for
> > your continued work on this.
> > 
> > (Although I admit to not reviewing 100% of the code)
> 
> Could you find some time to spare to review them?  You can grab them from:
> 
> 	http://people.redhat.com/~dhowells/nfs/nfs+fscache-14.tar.bz2

Any reason the 64bit inode patches are included here?

04-fsmisc.diff:

	ACK.

07-block-afs.diff:

	ACK.

10-cachefiles-ia64.diff:

	ACK.

12-autofs-dcache.diff:

	ACK.

13-reiserfs-dcache.diff:

	ACK.

14-dcache-crunch.diff:

	ACK.

15-nfs-replace-null-dentries.diff:

	ACK.


I'll take a look at the actual interesting patches ASAP.  Could you please
get all those simpler bits into -mm and resend everything else as a patch
against -mm?

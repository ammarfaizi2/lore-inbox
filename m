Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVIAR4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVIAR4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVIAR4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:56:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7089 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030264AbVIAR4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:56:07 -0400
Date: Thu, 1 Sep 2005 18:56:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Teigland <teigland@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050901175603.GA6218@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	David Teigland <teigland@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901142708.GA24933@infradead.org> <1125588511.15768.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125588511.15768.52.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:28:30PM +0100, Alan Cox wrote:
> > That's GFS.  The submission is about a GFS2 that's on-disk incompatible
> > to GFS.
> 
> Just like say reiserfs3 and reiserfs4 or ext and ext2 or ext2 and ext3
> then. I think the main point still stands - we have always taken
> multiple file systems on board and we have benefitted enormously from
> having the competition between them instead of a dictat from the kernel
> kremlin that 'foofs is the one true way'

I didn't say anything agains a particular fs, just that your previous
arguments where utter nonsense.  In fact I think having two or more cluster
filesystems in the tree is a good thing.  Whether the gfs2 code is mergeable
is a completely different question, and it seems at least debatable to
submit a filesystem for inclusion that's still pretty new.

While we're at it I can't find anything describing what gfs2 is about,
what is lacking in gfs, what structual changes did you make, etc..

p.s. why is gfs2 in fs/gfs in the kernel tree?

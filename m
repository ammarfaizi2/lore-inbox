Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTDXHJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTDXHJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:09:58 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:6929 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261283AbTDXHJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:09:56 -0400
Date: Thu, 24 Apr 2003 08:21:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Neil Brown <neilb@cse.unsw.edu.au>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BK->CVS, kernel.bkbits.net
Message-ID: <20030424082157.A21972@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Neil Brown <neilb@cse.unsw.edu.au>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <20030417162723.GA29380@work.bitmover.com> <b7n46e$dtb$1@cesium.transmeta.com> <20030420003021.GA10547@work.bitmover.com> <16035.30645.648954.185797@notabene.cse.unsw.edu.au> <3EA6B61B.7030303@gmx.net> <20030424024549.GA10840@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424024549.GA10840@work.bitmover.com>; from lm@bitmover.com on Wed, Apr 23, 2003 at 07:45:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 07:45:49PM -0700, Larry McVoy wrote:
> Fast or safe, pick one.  CVS has no integrity check and you will never know
> if you have bad data or not.  And the BK checks find el cheapo memory dimms
> and all sorts of other problems all the time.  It even found a cache aliasing
> bug in SPARC/Linux...
> 
> The BK integrity check will tell you right away if any of your data is bad.
> *Everyone* hates the check until it saves their butt and then they decide
> it's not such a bad idea.  It's a lot like a seatbelt - you don't like it
> until something goes wrong.
> 
> BK != CVS.  You want fast and loose, by all means, use CVS, that's not our
> intended market and we don't care about fast where fast means bad data.

Well, 90% of the BK repositories are in read-only mode for me, i.e. just
mirros of some public repository.  I couldn't care less whether a
corruption sneaked in, I'll just reclone as soon as the mainers complains
my patches don't apply anymore :)  So putting this get faster hints
somewhere where they could be found easily (or even a go fast option
for bk clone that applies this..) would be really nice.


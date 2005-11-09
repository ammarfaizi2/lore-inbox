Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbVKIIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbVKIIGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbVKIIGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:06:49 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:48620 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965276AbVKIIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:06:48 -0500
Date: Wed, 9 Nov 2005 00:06:27 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Zach Brown <zach.brown@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, mark.fasheh@oracle.com
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
Message-ID: <20051109080627.GZ11488@ca-server1.us.oracle.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mark.fasheh@oracle.com
References: <43667913.4030401@oracle.com> <20051103124536.0191bea6.akpm@osdl.org> <20051103074312.GQ11488@ca-server1.us.oracle.com> <20051103165306.GA4923@infradead.org> <20051103205802.31121fc4.akpm@osdl.org> <436BA907.9080604@oracle.com> <20051104205914.GA11202@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104205914.GA11202@infradead.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 08:59:14PM +0000, Christoph Hellwig wrote:
> I think it's in pretty good shape now.  The stuct typedefs should go before
> we put it in mainline so we don't need to do a major sweep through everything
> just after it appeared in SCM history, but that's just a minor thingy.
> Else I'd say it looks good unless we see problems with the AOP_TRUNCATED_PAGE
> patch we should send it to linus after the time for the big core merges is
> over (aka in about a week or two)

	Ok, the OCFS2 git trees have the latest code, including the
AOP_TRUNCATED_PAGE patch, the OCFS2 locking changes, and the removal of
the typedefs.  Let us know if you see anything else.
	Andrew, the AOP_TRUNCATED_PAGE patch is also broken out at
http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.14/2005-11-08/broken-out/linux-2.6.14-aop-truncated-page-1.patch.
If you pull it via the OCFS2 git tree, you'll still need
http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.14/2005-11-08/broken-out/linux-2.6.14-mm1-aop-truncated-page-reiser4.patch
for reiser4.
	Thanks everyone for the comments and the help.

Joel

-- 

"There is no more evil thing on earth than race prejudice, none at 
 all.  I write deliberately -- it is the worst single thing in life 
 now.  It justifies and holds together more baseness, cruelty and
 abomination than any other sort of error in the world." 
        - H. G. Wells

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127


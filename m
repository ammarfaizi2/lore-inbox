Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVKCHni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKCHni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 02:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVKCHni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 02:43:38 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:54767 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751010AbVKCHnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 02:43:37 -0500
Date: Wed, 2 Nov 2005 23:43:12 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org,
       mark.fasheh@oracle.com
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
Message-ID: <20051103074312.GQ11488@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@infradead.org,
	mark.fasheh@oracle.com
References: <43667913.4030401@oracle.com> <20051103124536.0191bea6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103124536.0191bea6.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 12:45:36PM +1100, Andrew Morton wrote:
> Zach Brown <zach.brown@oracle.com> wrote:
> > readpage(), prepare_write(), and commit_write() callers are updated to
> >  understand the special return code AOP_TRUNCATED_PAGE in the style of
> >  writepage() and WRITEPAGE_ACTIVATE.  AOP_TRUNCATED_PAGE tells the caller that
> >  the callee has unlocked the page and that the operation should be tried again
> 
> Looks sane to me.   Can you carry this in the ocfs2 tree?

	No problem.  Give us a day or two to merge the changes to our
main trees.

Joel

-- 

"Baby, even the losers
 Get luck sometimes.
 Even the losers
 Keep a little bit of pride."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127


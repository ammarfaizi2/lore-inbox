Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUIMVB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUIMVB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268686AbUIMVB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:01:56 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:51127 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267829AbUIMVBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:01:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.9-rc1-mm5: Oops related to reiserfs, other stuff
Date: Mon, 13 Sep 2004 23:03:15 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200409132211.44109.rjw@sisk.pl> <20040913211836.A31310@infradead.org>
In-Reply-To: <20040913211836.A31310@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132303.15812.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 of September 2004 22:18, Christoph Hellwig wrote:
> On Mon, Sep 13, 2004 at 10:11:44PM +0200, Rafael J. Wysocki wrote:
> > Andrew,
> > 
> > There is a problem in 2.6.9-rc1-mm5 related to the reiserfs handling of 
ACLs.  
> > Namely, if a reiserfs partition is mounted with "-o acl", any attempt to 
> > create a file on it results in an Oops similar to this one:
> 
> Can you back out the generic ACL patch?  I suspect it's is fault although
> I don't see how.

I've backed the following patches:

generic-acl-support-for-permission-fix.patch
generic-acl-support-for-permission-keyfs-fix.patch
generic-acl-support-for-permission.patch

and it works now.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

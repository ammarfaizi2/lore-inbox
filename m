Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUBDSyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUBDSyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:54:49 -0500
Received: from web9705.mail.yahoo.com ([216.136.129.143]:62988 "HELO
	web9705.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263539AbUBDSyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:54:47 -0500
Message-ID: <20040204185446.91810.qmail@web9705.mail.yahoo.com>
Date: Wed, 4 Feb 2004 10:54:46 -0800 (PST)
From: Alok Mooley <rangdi@yahoo.com>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1075920386.27981.106.camel@nighthawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dave Hansen <haveblue@us.ibm.com> wrote:

> The "work until we get interrupted and restart if
> something changes
> state" approach is very, very common.  Can you give
> some more examples
> of just how a page fault would ruin the defrag
> process?
> 

What I mean to say is that if we have identified some
pages for movement, & we get preempted, the pages
identified as movable may not remain movable any more
when we are rescheduled. We are left with the task of
identifying new movable pages.

-Alok

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/

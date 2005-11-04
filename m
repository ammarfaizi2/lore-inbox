Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVKDSbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKDSbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKDSbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:31:53 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:43385 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750801AbVKDSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:31:52 -0500
Message-ID: <436BA907.9080604@oracle.com>
Date: Fri, 04 Nov 2005 10:31:35 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, mark.fasheh@oracle.com,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
References: <43667913.4030401@oracle.com>	<20051103124536.0191bea6.akpm@osdl.org>	<20051103074312.GQ11488@ca-server1.us.oracle.com>	<20051103165306.GA4923@infradead.org> <20051103205802.31121fc4.akpm@osdl.org>
In-Reply-To: <20051103205802.31121fc4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So for both -mm and for the ocfs2 team, leaving the patch in the ocfs2 git
> tree is the most convenient place for it.

Well, I don't think it matters much either way because we mostly test by
checking out of svn and buliding against -mm or patched distro kernels.  I'd
leave the details up to you and Joel (who maintains our ocfs2 git) -- whatever
is easiest for you guys.

> Obviously, merging it into Linus's tree will fix up everyone's patching
> problems, but it has no users at this time...

So, speaking of which, are there any barriers to merging OCFS2 now?  I think
Christoph's concerns (silly /proc files, vma walking, endian stuff) have been
addressed.

- z


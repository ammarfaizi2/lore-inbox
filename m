Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTHFOGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHFOGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:06:42 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:7578 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262290AbTHFOGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:06:40 -0400
Message-ID: <3F310B6D.6010608@namesys.com>
Date: Wed, 06 Aug 2003 18:06:37 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu> <20030805224152.528f2244.akpm@osdl.org>
In-Reply-To: <20030805224152.528f2244.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>But different filesystems will leave different amounts of dirty, unwritten
>data in memory at the end of the test.  On your machine, up to 200MB of
>dirty data could be sitting there in memory at the end of the timing
>interval.  You need to decide how to account for that unwritten data in the
>measurement.  Simply ignoring it as you have done is certainly valid, but
>is only realistic in a couple of scenarios:
>
unless I misunderstand something, he is running sync and not ignoring that.

I don't think ext2 is a serious option for servers of the sort that 
Linux specializes in, which is probably why he didn't measure it.

reiser4 cpu consumption is still dropping rapidly as others and I find 
kruft in the code and remove it.  Major kruft remains still.


-- 
Hans



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbTD1RPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTD1RPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:15:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31921 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261213AbTD1RPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:15:52 -0400
Message-ID: <3EAD645F.8060301@us.ibm.com>
Date: Mon, 28 Apr 2003 10:26:55 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <20030428171455.GC1068@Wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Let's say 32GB :)  It boots just fine with 2.5.68, no additional
>>patches.  There's even half a gig of lowmem free.
> 
> But what happens when you stress test it? No deadlocks?

Actually, it is pretty stable.  It OOM's a bit more easily, but that
isn't a surprise to anyone, especially with the smaller amount of
ZONE_NORMAL.  I routinely run kernel compiles for days on it with no
problems.

That is, of course, a NUMA-Q.  We're hoping to get a Summit box which is
just as big sometime soon.  It will be much more interesting.
-- 
Dave Hansen
haveblue@us.ibm.com


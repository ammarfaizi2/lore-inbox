Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSA3KEH>; Wed, 30 Jan 2002 05:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSA3KDs>; Wed, 30 Jan 2002 05:03:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38407 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289036AbSA3KDj>; Wed, 30 Jan 2002 05:03:39 -0500
Message-ID: <3C57C4DB.3020101@namesys.com>
Date: Wed, 30 Jan 2002 13:03:07 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-list] Re: [reiserfs-dev] Re: Note describing poordcache   utilization under high memory pressure
In-Reply-To: <3C56FE14.15EA248E@zip.com.au> <Pine.LNX.4.44.0201300113120.25123-100000@waste.org> <3C57A1A9.E31CDB13@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>But what we do *not* want to do is to reclaim memory "fairly" from
>all caches.  The value of a cached page should be measured in terms
>of the number of seeks required to repopulate it.  That's all.
>

This is a good point, and I would like it to be considered by ReiserFS 
developers in regards to internal nodes, and why Sizif's making internal 
nodes have a longer lifetime in his experimental code for squid helped 
performance.

Hans


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbUKTE4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbUKTE4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUKTEz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:55:56 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:59533 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263097AbUKTEve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:51:34 -0500
Message-ID: <419ECD57.7040306@namesys.com>
Date: Fri, 19 Nov 2004 20:51:35 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>	<419E1297.4080400@namesys.com> <16798.28061.485747.492855@samba.org>
In-Reply-To: <16798.28061.485747.492855@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:

>Hans,
>
> > Is this an fsync intensive benchmark?  If no, could you try with 
> > reiser4?  If yes, you might as well wait for us to optimize fsync first 
> > in reiser4.
>
>In the configuration I was running there are no fsync calls.
>
>I'll have a go with reiser4 soon and let you know how it goes. I'm
>also working on a new version of dbench that will better simulate the
>filesystem access patterns of Samba4.
>  
>
If you can describe what those are, it would do me a lot of good in 
regards to my understanding what it means about an fs to get a certain 
result on the benchmark, and what needs to be better optimized.

Cheers,

Hans



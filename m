Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTD1Qet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTD1Qet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:34:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52934 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261190AbTD1Qes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:34:48 -0400
Message-ID: <3EAD5AC1.7090003@us.ibm.com>
Date: Mon, 28 Apr 2003 09:45:53 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Realistic limit currently is ~16GB with an IA32 box.  For more you need
> an 64bit architecture.

Let's say 32GB :)  It boots just fine with 2.5.68, no additional
patches.  There's even half a gig of lowmem free.

curly:~# cat /proc/meminfo
MemTotal:     32688576 kB
MemFree:      32644196 kB
Buffers:          3632 kB
Cached:           8068 kB
SwapCached:          0 kB
Active:           9420 kB
Inactive:         4616 kB
HighTotal:    32112640 kB
HighFree:     32098240 kB
LowTotal:       575936 kB
LowFree:        545956 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             160 kB
Writeback:           0 kB
Mapped:           4596 kB
Slab:             8316 kB
Committed_AS:     5544 kB
PageTables:        260 kB
VmallocTotal:   114680 kB
VmallocUsed:      3792 kB
VmallocChunk:   110888 kB


-- 
Dave Hansen
haveblue@us.ibm.com


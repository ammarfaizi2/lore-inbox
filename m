Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUF3S4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUF3S4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUF3S4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:56:09 -0400
Received: from pier.botik.ru ([193.232.174.1]:46562 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id S266808AbUF3Szt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:55:49 -0400
Message-ID: <40E30C51.8000105@namesys.com>
Date: Wed, 30 Jun 2004 22:54:09 +0400
From: "E. Gryaznova" <grev@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [2.6.7-mm4: OOPS] kernel BUG at mm/mmap.c:1793
References: <40E2E28E.8010709@namesys.com> <20040630114157.59258adf.akpm@osdl.org>
In-Reply-To: <20040630114157.59258adf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"E. Gryaznova" <grev@namesys.com> wrote:
>  
>
>>this is reproducible for me problem:
>> This wilson mmap test (attached) causes the kernel BUG at mm/mmap.c:1793 
>> immediately after running.
>>    
>>
>
>I cannot trigger it here.  Does it happen every time?
>
Yes

>  How much memory does
>that machine have?
>
# cat /proc/meminfo
MemTotal:       254396 kB
MemFree:        195224 kB
Buffers:         12648 kB
Cached:          19244 kB
SwapCached:          0 kB
Active:          25000 kB
Inactive:        14668 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254396 kB
LowFree:        195224 kB
SwapTotal:     1052216 kB
SwapFree:      1052216 kB
Dirty:              20 kB
Writeback:           0 kB
Mapped:          11596 kB
Slab:            16236 kB
Committed_AS:    24996 kB
PageTables:        424 kB
VmallocTotal:   770040 kB
VmallocUsed:      6868 kB
VmallocChunk:   763152 kB

Thanks,
Lena



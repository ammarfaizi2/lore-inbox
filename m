Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVAFP7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVAFP7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVAFP7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:59:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48548 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262894AbVAFP6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:58:47 -0500
Message-ID: <41DD608A.80003@sgi.com>
Date: Thu, 06 Jan 2005 10:00:10 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Steve Longerbeam <stevel@mvista.com>, Hugh Dickins <hugh@veritas.com>,
       "cl >> Christoph Lameter" <clameter@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de>
In-Reply-To: <20050106144307.GB59451@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> 
> You need lazy hugetlbfs to use it (= allocate at page fault time,
> not mmap time). Otherwise the policy can never be applied. I implemented 
> my own version of lazy allocation for SLES9, but when I wanted to 
> merge it into mainline some other people told they had a much better 
> singing&dancing lazy hugetlb patch. So I waited for them, but they 
> never went forward with their stuff and their code seems to be dead
> now. So this is still a dangling end :/
> 
> If nothing happens soon regarding the "other" hugetlb code I will
> forward port my SLES9 code. It already has NUMA policy support.

Andi,

I too have been frustrated by this process.  I think Christoph Lameter
at SGI is looking at forward porting the "old" lazy hugetlbpage allocation
code.  Of course, the proof is in the "doing" of this and I am not sure
what other priorities he has at the moment.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

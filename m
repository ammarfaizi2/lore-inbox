Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUIJFpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUIJFpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268238AbUIJFpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:45:19 -0400
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:65179 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S268223AbUIJFpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:45:12 -0400
Message-ID: <41413F64.40504@bigpond.net.au>
Date: Fri, 10 Sep 2004 15:45:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org>
In-Reply-To: <20040909200650.787001fc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>> Andrew Morton wrote:
>> > Peter Williams <pwil3058@bigpond.net.au> wrote:
>> > 
>> >>>Please try earlier snapshots, see if you can ascertain which one introduced
>> >>>the bug.
>>
>> bk10 is where the problem was introduced.
>  bit.
> 
> OK, thanks for hanging in there.
> 
> I've placed four backout patches at
> http://www.zip.com.au/~akpm/linux/patches/stuff/pid-revert/.  Could you
> please try them, see which one fixes it up?  
> 
> Grab the latest Linus snapshot and apply them in this order:
> 
> 1-1911-3-2.patch

Still there with this one PLUS I now get a whole bunch of "scheduling 
while atomic" errors when I do "make install" which fails due to a 
segmentation fault while doing the mkinitrd bit.

> 1-1901-1-17.patch
> 1-1860-1-29.patch
> 1-1860-1-28.patch
> 
> Thanks.
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce


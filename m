Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUIJG2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUIJG2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUIJG2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:28:54 -0400
Received: from gizmo12bw.bigpond.com ([144.140.70.43]:53122 "HELO
	gizmo12bw.bigpond.com") by vger.kernel.org with SMTP
	id S268280AbUIJG2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:28:52 -0400
Message-ID: <414149A0.1050006@bigpond.net.au>
Date: Fri, 10 Sep 2004 16:28:48 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org> <41413F64.40504@bigpond.net.au> <20040909231858.770ab381.akpm@osdl.org>
In-Reply-To: <20040909231858.770ab381.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>>Grab the latest Linus snapshot and apply them in this order:
>>>
>>>1-1911-3-2.patch
>>
>>Still there with this one PLUS I now get a whole bunch of "scheduling 
>>while atomic" errors when I do "make install" which fails due to a 
>>segmentation fault while doing the mkinitrd bit.
> 
> 
> Yup, one or two of these patches are "fix up the previous patch" things.
> 
> 
>>>1-1901-1-17.patch
>>>1-1860-1-29.patch
>>>1-1860-1-28.patch
> 
> 
> Please keep going ;)
> 

All the way through and it's still occurring.  After the second patch 
the symptoms changed slightly and it was a different gdm program that 
triggered the oops.  But with all patches applied it's back to the 
original symptoms.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce


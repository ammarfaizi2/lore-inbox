Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUBSSx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUBSSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:52:21 -0500
Received: from mail6.fw-sj.sony.com ([160.33.82.73]:29926 "EHLO
	mail6.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S267477AbUBSSux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:50:53 -0500
Message-ID: <4035077E.5020506@am.sony.com>
Date: Thu, 19 Feb 2004 10:59:10 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osd.org, paulmck@us.ibm.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
References: <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218162858.2a230401.akpm@osdl.org> <20040219123110.A22406@infradead.org>
In-Reply-To: <20040219123110.A22406@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Feb 18, 2004 at 04:28:58PM -0800, Andrew Morton wrote: 
>>OK, so I looked at the wrapper.  It wasn't a tremendously pleasant
>>experience.  It is huge, and uses fairly standard-looking filesytem
>>interfaces and locking primitives.  Also some awareness of NFSV4 for some
>>reason.
>> 
>>Still, the wrapper is GPL so this is not relevant.
> 
> Well, something that needs an almost one megabyte big wrapper per defintion
> is not a standalone work but something that's deeply interwinded with
> the kernel.  The tons of kernel version checks certainly show it's poking
> deeper than it should.
>...
 >
> Something that pokes deep into internal structures and even
> needs new exports certainly is a derived work. 

I'd argue (again) that having a complex glue layer is not evidence
per se of the glued module being a derived work.  If anything,
it is evidence to the contrary.  But it depends on the circumstances.

The question for GPFS itself is whether it was modified to run with
Linux, and how it was modified, and how much it was modified.

If your argument is that Linux, after being modified with the glue
layer, is now a derivative work of the glued module, that seems
more likely.  I'm not sure how the GPL reads on that case.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================


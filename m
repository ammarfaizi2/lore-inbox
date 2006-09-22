Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWIVUOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWIVUOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWIVUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:14:24 -0400
Received: from dvhart.com ([64.146.134.43]:20713 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964868AbWIVUOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:14:23 -0400
Message-ID: <4514441E.70207@mbligh.org>
Date: Fri, 22 Sep 2006 13:14:22 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Lameter <clameter@sgi.com>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <200609222110.25118.ak@suse.de> <1158955850.24572.37.camel@localhost.localdomain> <200609222202.41692.ak@suse.de>
In-Reply-To: <200609222202.41692.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And is fine with 16MB anyways I think.
> 
> 
>>- Some aacraid, mostly only for control structures. Those found on 64bit
>>are probably fine with slow alloc.
> 
> 
> That is the only case where there are rumours they are not fine with 16MB.
> 
> 
>>- Broadcom stuff - not sure if 30 or 31bit, around today and on 64bit
> 
> 
> b44 is 30bit. That's true. I even got one here.
> 
> But it doesn't count really because we can handle it fine with existing 
> 16MB GFP_DMA

The problem is that GFP_DMA does not mean 16MB on all architectures.

M.

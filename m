Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312274AbSCUOfZ>; Thu, 21 Mar 2002 09:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312338AbSCUOfQ>; Thu, 21 Mar 2002 09:35:16 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:8116 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S312274AbSCUOfH>;
	Thu, 21 Mar 2002 09:35:07 -0500
Date: Thu, 21 Mar 2002 06:34:20 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <337737911.1016692459@[10.10.2.3]>
In-Reply-To: <20020320194549.A32457@infradead.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, March 20, 2002 7:45 PM +0000 Christoph Hellwig <hch@infradead.org> wrote:

> [Any chance to make your mailer wrap lines after 76 lines?
>  That would make reading a lot easier..]
> 
> On Wed, Mar 20, 2002 at 11:09:05AM -0800, Martin J. Bligh wrote:
>> Imagine we create a hybrid "u-k-space" with the protections of k-space, but the locality
>> of u-space .... either by making part of the current k-space per task or by making part of
>> the current u-space protected like k-space ... not sure which would be easier.
>> 
>> This u-k-space would be a good area for at least two things (and probably others):
> 
> That has been implemented in Caldera OpenUnix in the last years.
> There was a nice overview paper by Steve Baumel and Rohit Chawla on this,
> called "Managing More Physical With Less Virtual" which I think appeared
> in some Y2000 Byte issue.

The only reference that I could find was this:

http://www.informatik.uni-trier.de/~ley/db/journals/spe/spe30.html

and I can't find the actual paper online anywhere ... is it available?

Thanks,

Martin.


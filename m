Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314684AbSEBRaX>; Thu, 2 May 2002 13:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314686AbSEBRaW>; Thu, 2 May 2002 13:30:22 -0400
Received: from holomorphy.com ([66.224.33.161]:4823 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314684AbSEBRaV>;
	Thu, 2 May 2002 13:30:21 -0400
Date: Thu, 2 May 2002 10:28:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Engebretsen <engebret@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502172820.GK32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Engebretsen <engebret@vnet.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <20020502030113.Q11414@dualathlon.random> <20020502152825.GE10495@krispykreme> <20020502163135.GI32767@holomorphy.com> <3CD167A7.3EFEC1B5@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Would the flip side of that coin perhaps be implementing a way to be a
>> good logically partitioned citizen and cooperatively offline memory?
>> Cheers,
>> Bill

On Thu, May 02, 2002 at 11:21:59AM -0500, Dave Engebretsen wrote:
> Yes, both add and remove are needed to be a good citizen.  One could
> spend all kinds of time coming up with good huristicts to do that
> automatically :)
> At a mimimum, manual off line of memory would be nice.
> Dave.

I have a particular interest in the implementation of at least one
mechanism in the kernel (rmap) which could be exploited to assist
in this. If there are other efforts in progress toward this end I'd
be happy to investigate methods of using the additional machinery
provided by rmap to assist in this.


Cheers,
Bill

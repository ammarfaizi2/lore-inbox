Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311314AbSCTWFQ>; Wed, 20 Mar 2002 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311397AbSCTWE5>; Wed, 20 Mar 2002 17:04:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25757 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S311314AbSCTWEu>; Wed, 20 Mar 2002 17:04:50 -0500
Date: Wed, 20 Mar 2002 15:20:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020320152008.A19978@vger.timpanogas.org>
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 02:02:41PM -0800, Mike Fedyk wrote:
> On Wed, Mar 20, 2002 at 12:04:55PM -0700, Jeff V. Merkey wrote:
> > 
> > 
> > 
> > Jens/Linux,
> > 
> > The elevator code is malfunctioning in 2.4.18/19-pre when we start 
> > reaching the upward limits with multiple 3Ware adapters 
> > running together.  We started seeing the problem when we went to 
> > 64 K aligned writes with sustained > 200 MB/S writes to 
> > multiple 3Ware adapters.  
> > 
> > We have verified that the 3Ware adapters are not holding the request
> > off, but that one of the requests is getting severely starved and
> > does not get posted to the 3Ware adapters until thousands of IOs
> > have gone before it.  
> > 
> 
> This elevator starvation problem has been identified and a patch already
> merged into 2.4.19-pre2.
> 
> Can you verify the affects it produces for your workload?

I will comply.  I tested with pre-3 patches and still saw this problem??
Let me go and check the patches I applied to verify, I may not have 
applied the correct patch.

Jeff






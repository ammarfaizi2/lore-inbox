Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285159AbRLFMae>; Thu, 6 Dec 2001 07:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285160AbRLFMaX>; Thu, 6 Dec 2001 07:30:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49602 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S285159AbRLFMaJ>;
	Thu, 6 Dec 2001 07:30:09 -0500
Date: Thu, 6 Dec 2001 18:03:53 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Niels Christiansen <nchr@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011206180353.E20583@in.ibm.com>
In-Reply-To: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com>; from nchr@us.ibm.com on Wed, Dec 05, 2001 at 10:02:33AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niels,
 
On Wed, Dec 05, 2001 at 10:02:33AM -0500, Niels Christiansen wrote:
>
> I'm wondering about the scope of this.  My Ethernet adapter with, maybe, 20
> counter fields would have 20 counters allocated for each of my 16
> processors.
> The only way to get the total would be to use statctr_read() to merge them.
> Same for the who knows how many IP counters etc., etc.
 
Are you concerned with increase in memory used per counter Here? I suppose
that must not be that much of an issue for a 16 processor box....
 
>
> How many and which counters were converted for the test you refer to?
>
 
Well, I wrote a simple kernel module which just increments a shared global
counter a million times per processor in parallel, and compared it with
the statctr which would be incremented a million times per processor in
parallel..
 
> I do like the idea of a uniform access mechanism, though.  It is well in
> line
> with my thoughts about an architected interface for topology and
> instrumentation
> so I'll definitely get back to you as I try to collect requirements.
>
> Niels
 
Hope we can come out with a really cool and acceptable interface..

Kiran
-- 
Ravikiran G Thirumalai <kiran@in.ibm.com>
Linux Technology Center, IBM Software Labs,
Bangalore.

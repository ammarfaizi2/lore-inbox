Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283118AbRK2JaJ>; Thu, 29 Nov 2001 04:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283122AbRK2JaA>; Thu, 29 Nov 2001 04:30:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55227 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283118AbRK2J3w>; Thu, 29 Nov 2001 04:29:52 -0500
Date: Thu, 29 Nov 2001 10:06:09 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: bio write up - Updated notes on block layer design changes
Message-ID: <20011129100609.A1356@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20011128154533.A1437@in.ibm.com> <20011128220130.K23858@suse.de> <20011129044644.A1717@in.ibm.com> <20011129075720.B5788@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011129075720.B5788@suse.de>; from axboe@suse.de on Thu, Nov 29, 2001 at 07:57:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 07:57:20AM +0100, Jens Axboe wrote:

> I've lost track of what else there is to explain, so I'll stop now. If
> you have problems convering a driver or questions in general, fire away.
> Suparana@IBM has written lots of stuff about bio as it was a WIP, see
>
> http://lse.sourceforge.net/io/bionotes.txt
>
> it may not be completely uptodate right now wrt multi-page bios etc, but
> I know that is on its way :-)
> 
> -- 
> Jens Axboe

I just posted the updated design notes covering the multi-page bios.
Same place: i.e. http://lse.sourceforge.net/io/bionotes.txt

The intent of these notes is to set the changes in the context of past
discussions related to the block layer design. It attempts to cover some of the
alternatives and ideas put forth by various people, analyse pros and cons,
cover the rationale behind some of the design decisions, and peek into a
few ideas that people are thinking about/ working on, which may not already
be in there yet.

Any additions to make this more complete/interesting or any corrections (I may
have missed some things) are welcome.

Regards
Suparna

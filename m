Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSJCXFL>; Thu, 3 Oct 2002 19:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJCXFL>; Thu, 3 Oct 2002 19:05:11 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:50130 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S261412AbSJCXFJ>; Thu, 3 Oct 2002 19:05:09 -0400
Date: Thu, 3 Oct 2002 17:10:13 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021003171013.B22986@mail.harddata.com>
References: <20021003153943.E22418@openss7.org> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033682560.28850.32.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 03, 2002 at 11:02:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 11:02:40PM +0100, Alan Cox wrote:
> On Thu, 2002-10-03 at 22:39, Brian F. G. Bidulock wrote:
> 
> > Until now, loadable modules have been able to just overwrite
...
> 
> Not actually safely implementable. The right way to do this is a
> relevant 2.5 question. In general however you shouldnt need to register
> syscalls because the upper layer interfaces already exist (the LiS stuff
> is an example otherwise I grant). 

Hm, IIRC bproc stuff (Beowulf support) also relies on this ability.
Or at least "kmonte" trick to load and switch to a new kernel.

  Michal

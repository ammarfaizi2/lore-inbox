Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbULQC2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbULQC2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 21:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbULQC2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 21:28:42 -0500
Received: from koto.vergenet.net ([210.128.90.7]:41412 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262723AbULQC2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 21:28:36 -0500
Date: Fri, 17 Dec 2004 11:28:20 +0900
From: Horms <horms@verge.net.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jason Baron <jbaron@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: tty/ldisc fix in 2.4
Message-ID: <20041217022818.GA7844@verge.net.au>
References: <20041216081452.GA8113@logos.cnet> <Pine.LNX.4.44.0412161002520.28739-100000@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412161002520.28739-100000@dhcp83-105.boston.redhat.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 10:08:34AM -0500, Jason Baron wrote:
> 
> On Thu, 16 Dec 2004, Marcelo Tosatti wrote:
> 
> > On Thu, Dec 16, 2004 at 01:42:29PM +0900, Horms wrote:
> > > Hi,
> > 
> > Hi Horms,
> > 
> > > I am unable to find a fix for the tty/ldisc problem (CAN-2004-0814)
> > > in 2.4.28 or 2.4 bitkeeper. I am wondering if anyone can either
> > > point me to what I am missing or indicate if there is a reason
> > > the patch hasn't been included. e.g. it slipped through the cracks.
> > 
> > The patch has not been included in 2.4.28 because it was too late in the 
> > v2.4.28 cycle for them to be included - they are quite intrusive.
> > 
> > And they there didnt seem stable at the time - but yes - we
> > should now make an effort to include the locking fixes in 2.4.29. 
> > 
> > > The last I can find of it is here:
> > > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1750.html
> > 
> > Jason, can you point us at your last patch ? 

> the latest one was the last one posted to this list plus Sergey's fixes.  
> However, i think it was still missing some driver cleanups. I'll post an
> updated patch here.

Hi,

thanks to all for the update. This definately answers my question.
I will watch out for Jason's updated patch.

-- 
Horms

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316433AbSEOQfE>; Wed, 15 May 2002 12:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSEOQfD>; Wed, 15 May 2002 12:35:03 -0400
Received: from air-2.osdl.org ([65.201.151.6]:272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316433AbSEOQfC>;
	Wed, 15 May 2002 12:35:02 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
From: Stephen Hemminger <shemminger@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020515010107.A31154@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 May 2002 09:34:34 -0700
Message-Id: <1021480474.32059.7.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-14 at 22:01, Pete Zaitcev wrote:
 
> The thing about Infiniband is that its scope is so great.
> If you consider Infiniband was only a glorified PCI with serial
> connector, the congestion control is not an issue. Credits
> are quite sufficient to provide per link flow control, and
> everything would work nicely with a couple of switches.
> Such was the original plan, anyways, but somehow cluster
> ninjas managed to hijack the spec and we have the rabid
> overengineering running amok. In fact, they ran so far
> that Intel jumped ship and created PCI Express, and we
> have discussions about congestion control. Sad, really...
> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

This sounds like deja vu all over again.
Each new interconnect technology like ATM seems to go through the cycle:

	Assert: all other network protocols are crap
	Deny: history
	Assert: our problem is different, therefore we must
	        reinvent everything from data transfer up to 		applications

	Reality strikes!

	New technology ends up being used with standard applications and
	protocols.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUHLTxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUHLTxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUHLTxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:53:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42460 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268697AbUHLTwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:52:40 -0400
Date: Thu, 12 Aug 2004 14:51:59 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Distribution for Power4 Machines
Message-Id: <20040812145159.3614473f@localhost>
In-Reply-To: <pan.2004.08.11.17.20.38.570218@triplehelix.org>
References: <20040811055622.52917.qmail@web13911.mail.yahoo.com>
	<15070000.1092237689@[10.10.2.4]>
	<1092238482.6033.4.camel@nighthawk>
	<pan.2004.08.11.17.20.38.570218@triplehelix.org>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks to Sven Luther our new installer fully supports power4 (as far as
> I know, I don't personally own one.)
> 
> http://gluck.debian.org/cdimage/testing/daily/powerpc/current/
> 
> should contain a CD image that can boot your machine.

Unless they fixed this very recently, the kernels they build for power4
are the 32-bit ones.  Which work fine if you are booting power4 natively
(ie without it running in partition).  As soon as a power4 box is
running in a partition the kernel breaks because the 32-bit one does not
have the hypervisor calls.

I know Tom Gall has been working on Gentoo for ppc64.  

	http://dev.gentoo.org/~tgall/

Thanks,
Jake

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUH2QsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUH2QsB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUH2QsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:48:01 -0400
Received: from the-village.bc.nu ([81.2.110.252]:24705 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268119AbUH2Qr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:47:58 -0400
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jmerkey@drdos.com
In-Reply-To: <20040829164239.GH5492@holomorphy.com>
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
	 <20040826043318.GO2793@holomorphy.com> <52isb6bj64.fsf@topspin.com>
	 <20040826044954.GP2793@holomorphy.com>
	 <1093783694.27899.7.camel@localhost.localdomain>
	 <20040829164239.GH5492@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093794337.28141.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 16:45:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-29 at 17:42, William Lee Irwin III wrote:
> On Iau, 2004-08-26 at 05:49, William Lee Irwin III wrote:
> The big nasty is that userspace has very little to go on here. We need
> to report the limits of the address space somewhere for this kind of
> affair and probably even hammer out our own addenda to ABI specs so
> instead of SVR4 $ARCH/ELF ABI spec we have a Linux $ARCH/ELF ABI spec.
> I see no one so motivated to make backward-incompatible ABI changes
> that they are willing to do that kind of work.

Ok so I can compile with a.out support. End of problem, that makes the
patch useful and "spec compliant", although the spec compliance is
irrelevant anyway. The spec doesn't determine what Linux is it's a
useful reference for normality. Special cases are special cases and you
harm the system by seeking to stop stuff that works purely for pieces of
paper.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUH2Qmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUH2Qmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH2Qmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:42:54 -0400
Received: from holomorphy.com ([207.189.100.168]:23726 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268119AbUH2Qmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:42:46 -0400
Date: Sun, 29 Aug 2004 09:42:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040829164239.GH5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jmerkey@drdos.com
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net> <20040826043318.GO2793@holomorphy.com> <52isb6bj64.fsf@topspin.com> <20040826044954.GP2793@holomorphy.com> <1093783694.27899.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093783694.27899.7.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-26 at 05:49, William Lee Irwin III wrote:
>> Though asinine, the ABI spec is set in stone.

On Sun, Aug 29, 2004 at 01:48:14PM +0100, Alan Cox wrote:
> Lots of Linux configuration options build you systems that don't meet
> some specifications. "Intentionally violate a stupid spec to get work
> done" is a good option 8)

The big nasty is that userspace has very little to go on here. We need
to report the limits of the address space somewhere for this kind of
affair and probably even hammer out our own addenda to ABI specs so
instead of SVR4 $ARCH/ELF ABI spec we have a Linux $ARCH/ELF ABI spec.
I see no one so motivated to make backward-incompatible ABI changes
that they are willing to do that kind of work.


-- wli

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265288AbRFUXSd>; Thu, 21 Jun 2001 19:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265287AbRFUXSX>; Thu, 21 Jun 2001 19:18:23 -0400
Received: from juicer02.bigpond.com ([139.134.6.78]:44242 "EHLO
	mailin5.bigpond.com") by vger.kernel.org with ESMTP
	id <S265288AbRFUXSL>; Thu, 21 Jun 2001 19:18:11 -0400
Message-Id: <m15CvoL-001UJEC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads) 
In-Reply-To: Your message of "Wed, 20 Jun 2001 14:35:25 EDT."
             <Pine.GSO.4.21.0106201429150.26389-100000@weyl.math.psu.edu> 
Date: Thu, 21 Jun 2001 14:11:17 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0106201429150.26389-100000@weyl.math.psu.edu> you wri
te:
> In practice it's a BS. There is a lot of ways minor modifications of code
> could add a preemption point, so if you rely on the lack of such - expect
> major PITA.
> 
> Yes, in theory SMP adds some extra fun. Practically, almost every "SMP"
> race found so far did not require SMP.

Disagree.  A significant percentage of the netfilter bugs have been
SMP only (the whole thing is non-reentrant on UP).

Depends what part of the kernel you play in,
Rusty.
--
Premature optmztion is rt of all evl. --DK

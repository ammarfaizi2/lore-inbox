Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310162AbSCAXVJ>; Fri, 1 Mar 2002 18:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310165AbSCAXVA>; Fri, 1 Mar 2002 18:21:00 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:51460 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310162AbSCAXUt>;
	Fri, 1 Mar 2002 18:20:49 -0500
Date: Sat, 2 Mar 2002 01:20:46 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, <kain@kain.org>
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <p73pu2nki53.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0203020110280.1706-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On 2 Mar 2002, Andi Kleen wrote:

> Short term fix would be just to add a spinlock like this (untested).

	Yes, I don't see more places. I'm only not sure 
whether it should be fib_info_lock instead of fib_nh_lock, may be no.

> I think using a new algorithm would be too risky at least for 2.4.

	Yes, it seems I have to test it first.

Regards

--
Julian Anastasov <ja@ssi.bg>


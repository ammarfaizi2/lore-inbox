Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284491AbRLRSn0>; Tue, 18 Dec 2001 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284542AbRLRSlv>; Tue, 18 Dec 2001 13:41:51 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:21486 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284540AbRLRSkx>; Tue, 18 Dec 2001 13:40:53 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181521.fBIFLZ716040@pinkpanther.swansea.linux.org.uk>
Subject: Re: mempool design
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 18 Dec 2001 15:21:35 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), bcrl@redhat.com (Benjamin LaHaise),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20011217160426.U2431@athlon.random> from "Andrea Arcangeli" at Dec 17, 2001 04:04:26 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If somebody wants such 1% of ram back he can buy another dimm of ram and
> plug it into his hardware. I mean such 1% of ram lost is something that
> can be solved by throwing a few euros into the hardware (and people buys
> gigabyte boxes anyways so they don't need all of the 100% of ram), the

How do I add dimms to an embedded board ?

> solved with lots braincycles and it would be a maintainance work as
> well. Abstraction and layering definitely helps cutting down the
> complexity of the code.

I'm not too worried. mempool as an API can relatively easily be persuaded
to do reservations on an underlying allocator some point in the future.

Alan


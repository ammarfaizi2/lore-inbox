Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUHVCJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUHVCJe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUHVCJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:09:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:152 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265161AbUHVCJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:09:33 -0400
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <871xi0te7o.fsf@dedasys.com>
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	 <873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	 <87llgfdqb7.fsf@dedasys.com> <874qn353on.fsf@dedasys.com>
	 <1092729140.9539.129.camel@gaston> <87k6vytbjo.fsf@dedasys.com>
	 <1092732749.10506.151.camel@gaston> <87isbh6hxd.fsf@dedasys.com>
	 <871xi0te7o.fsf@dedasys.com>
Content-Type: text/plain
Message-Id: <1093139922.9538.274.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 11:58:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The only thing that jumps out at me is that arch/ppc/mm/cachemap.c
> 'moved' to arch/ppc/kernel/dma-mapping.c and seems to have changed
> some as well.  Other than that, I would need more suggestions for
> debugging.

No, that's probably irrelevant. I'll have a look when I'm back, I've
been away for the week-end.

Ben.



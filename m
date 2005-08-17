Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVHQDdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVHQDdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVHQDdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:33:45 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:20663
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1750816AbVHQDdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:33:44 -0400
Date: Tue, 16 Aug 2005 20:33:12 -0700 (PDT)
Message-Id: <20050816.203312.77701192.davem@davemloft.net>
To: paulus@samba.org
Cc: galak@freescale.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17154.38156.13295.731022@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
	<17154.38156.13295.731022@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 17 Aug 2005 11:38:20 +1000

> Kumar Gala writes:
> 
> > Made <asm/segment.h> a dummy include like it is in ppc64 and removed any
> > users if it in arch/ppc.
> 
> Why can't we just delete asm-ppc/segment.h (and asm-ppc64/segment.h
> too, for that matter) entirely?

I concur, in fact we should really kill that thing off entirely.

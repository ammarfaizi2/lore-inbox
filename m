Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755875AbWKWENL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbWKWENL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 23:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbWKWENL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 23:13:11 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42880
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1755875AbWKWENI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 23:13:08 -0500
Date: Wed, 22 Nov 2006 20:13:11 -0800 (PST)
Message-Id: <20061122.201311.45745181.davem@davemloft.net>
To: akpm@osdl.org
Cc: eric.valette@free.fr, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl,
       torvalds@osdl.org
Subject: Re: FYI build failure : 2.6.19-rc6-git5 unresolved
 spin_lock_irqsave_nested
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061122154125.babd0cec.akpm@osdl.org>
References: <4564C34C.7050000@free.fr>
	<20061122154125.babd0cec.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 22 Nov 2006 15:41:25 -0800

> Linus merged a lockdep fixup patch which was dependent upon infrastructure
> which is only in -mm.
> 
> I'll send lockdep-spin_lock_irqsave_nested.patch (and its two fixes) (and
> enforce-unsigned-long-flags-when-spinlocking.patch which precedes it) along
> to Linus in the next batch, so this will come right.

Thanks.  Sorry about that.

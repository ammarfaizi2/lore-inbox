Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268754AbTCCTyu>; Mon, 3 Mar 2003 14:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268755AbTCCTyu>; Mon, 3 Mar 2003 14:54:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32684 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268754AbTCCTyt>;
	Mon, 3 Mar 2003 14:54:49 -0500
Date: Mon, 03 Mar 2003 11:47:23 -0800 (PST)
Message-Id: <20030303.114723.65560821.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: porter@cox.net, linux-kernel@vger.kernel.org
Subject: Re: *dma_sync_single API change to support non-coherent cpus
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030303195825.C17997@flint.arm.linux.org.uk>
References: <20030303111848.A31278@home.com>
	<20030303195825.C17997@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Mon, 3 Mar 2003 19:58:25 +0000
   
   DaveM, as the author of the original PCI DMA API, any comments on this
   (probably ill-thoughtout) idea?

Maybe a better idea is to kill map_single() altogether, and use
scatterlists everywhere.

Long term this is the kind of consolidation that ought to
happen anyways.

And then the implementation can stick whatever it wants in there.

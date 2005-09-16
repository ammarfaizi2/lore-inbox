Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbVIPKwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbVIPKwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVIPKwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:52:22 -0400
Received: from ozlabs.org ([203.10.76.45]:48307 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965296AbVIPKwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:52:22 -0400
Date: Fri, 16 Sep 2005 20:42:27 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-task-predictive-write-throttling-1
Message-ID: <20050916104227.GD14962@krispykreme>
References: <20050914220334.GF4966@opteron.random> <200509151044.24002.kernel@kolivas.org> <20050915171420.GG4122@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915171420.GG4122@opteron.random>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Andrea,

> BTW, I tested dbench (not after a fresh mke2fs so there might be
> minor fragmentation variations) and it doesn't seem affected by it (it's
> in the noise range) and I take it as a good thing. dbench keeps looking
> weird, if you notice the lower bandwidth of 273 completed in 12m13s
> while the higher bandwidth of 291 completed in 12m15s... perhaps it
> prints the best bandwith of the passes and it's not an average.

>From memory, if you are using a recent version of dbench it runs for a
constant amount of time. The old version ran a constant number of
operations (and so runtimes varied based on your performance).

Anton

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWHAIqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWHAIqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWHAIqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:46:39 -0400
Received: from colin.muc.de ([193.149.48.1]:21513 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750914AbWHAIqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:46:39 -0400
Date: 1 Aug 2006 10:46:37 +0200
Date: Tue, 1 Aug 2006 10:46:37 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Vitezslav Samel <samel@mail.cz>, linux-kernel@vger.kernel.org
Subject: Re: too low MAX_MP_BUSSES
Message-ID: <20060801084637.GB21698@muc.de>
References: <20060731115545.GA3292@pc11.op.pod.cz> <20060801013826.09c9324d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801013826.09c9324d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mach-default uses 32 and mach-generic uses 260, so I doubt if there's a big
> downside to increasing mach-default.  I expect distros ship with
> mach-generic, so you're a rare case.
> 
> <tries to remember who works on this and fails>
> 
> Andi?  Can you see any problems with increasing the mach-default setting?

No, except for wasting a bit of memory (maybe make it dependent on CONFIG_TINY?)

-Andi

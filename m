Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278805AbRKHXAo>; Thu, 8 Nov 2001 18:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278789AbRKHXAe>; Thu, 8 Nov 2001 18:00:34 -0500
Received: from ns.suse.de ([213.95.15.193]:56324 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278755AbRKHXAa>;
	Thu, 8 Nov 2001 18:00:30 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Nov 2001 00:00:19 +0100
In-Reply-To: Ingo Molnar's message of "8 Nov 2001 17:46:06 +0100"
Message-ID: <p731yj8kgvw.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> 
> we should fix this by trying to allocate continuous physical memory if
> possible, and fall back to vmalloc() only if this allocation fails.

Check -aa. A patch to do that has been in there for some time now.

-Andi

P.S.: It makes a measurable difference with some Oracle benchmarks with
the Qlogic driver.


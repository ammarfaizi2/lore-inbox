Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSAUJcR>; Mon, 21 Jan 2002 04:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289122AbSAUJcH>; Mon, 21 Jan 2002 04:32:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2030 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287720AbSAUJbv>;
	Mon, 21 Jan 2002 04:31:51 -0500
Date: Mon, 21 Jan 2002 12:29:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O(1) scheduler unlock_task_rq
In-Reply-To: <1011570657.850.362.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201211228370.3032-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Jan 2002, Robert Love wrote:

> In Ingo's new O(1) scheduler, unlock_task_rq takes a pointless
> argument (task_t * p).
>
> This patch, against 2.5.3-pre2 + J2, removes the argument and fixes
> all known uses of the function.

thanks Robert - i've added this to my tree.

	Ingo


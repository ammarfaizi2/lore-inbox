Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbTCYGPE>; Tue, 25 Mar 2003 01:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbTCYGPE>; Tue, 25 Mar 2003 01:15:04 -0500
Received: from mx1.elte.hu ([157.181.1.137]:45549 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261464AbTCYGPD>;
	Tue, 25 Mar 2003 01:15:03 -0500
Date: Tue, 25 Mar 2003 07:25:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] trivial task_prio() fix
In-Reply-To: <1048558471.1486.171.camel@phantasy.awol.org>
Message-ID: <Pine.LNX.4.44.0303250722330.19394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Mar 2003, Robert Love wrote:

>  int task_prio(task_t *p)
>  {
> -	return p->prio - MAX_USER_RT_PRIO;
> +	return p->prio - MAX_RT_PRIO;
>  }

looks good to me.

	Ingo


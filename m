Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318988AbSHSTKS>; Mon, 19 Aug 2002 15:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318989AbSHSTKS>; Mon, 19 Aug 2002 15:10:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33472 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318988AbSHSTKS>;
	Mon, 19 Aug 2002 15:10:18 -0400
Date: Mon, 19 Aug 2002 21:15:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <3D613F20.9E5E3B84@mvista.com>
Message-ID: <Pine.LNX.4.44.0208192115001.31716-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, george anzinger wrote:

> The current way its done, a child can not get the pid of its father and
> thus would NEED to know it was being traced in order to do anything that
> required such. [...]

what do you mean by this? sys_getppid() uses ->real_parent so it gets the 
proper PID.

	Ingo


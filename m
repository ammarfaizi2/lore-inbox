Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSBZWek>; Tue, 26 Feb 2002 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293609AbSBZWea>; Tue, 26 Feb 2002 17:34:30 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:57362 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S292688AbSBZWeS>; Tue, 26 Feb 2002 17:34:18 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 26 Feb 2002 14:37:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.3.95.1020226161330.7314A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0202261435281.1544-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Richard B. Johnson wrote:

> On Tue, 26 Feb 2002, Davide Libenzi wrote:
> >
> > In 2.5 yield() maps to sys_sched_yield(). You can handle it in the same
> > way in your includes if version <= 2.4.
>
> It's not exported as well as not defined in a header! It results in
> an undefined symbol in the module.

You can try to ask Marcelo to add a line in include/linux/sched.h and one
in kernel/ksym.c
In this way a compatibility interface can be achieved for code that needs it.




- Davide



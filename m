Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287573AbSANQT5>; Mon, 14 Jan 2002 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287612AbSANQTr>; Mon, 14 Jan 2002 11:19:47 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:2319 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287573AbSANQTa>; Mon, 14 Jan 2002 11:19:30 -0500
Date: Mon, 14 Jan 2002 17:19:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <yodaiken@fsmlabs.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0201141216520.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0201141709000.29792-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jan 2002, Rik van Riel wrote:

> Without preemption task C would not have been preempted and it would
> have released the lock much sooner, meaning task A could have gotten
> the resource earlier.

Define "much sooner", nobody disputes that low priority tasks can be
delayed, that's actually the purpose of both patches.

> Using the low latency patch we'd insert some smart code into the
> algorithm so task A also releases the lock before rescheduling.

Could you please show me that "smart code"?

> Before you say this thing never happens in practice, I ran into
> this thing in real life with the SCHED_IDLE patch. In fact, this
> problem was so severe it convinced me to abandon SCHED_IDLE ;))

SCHED_IDLE is something completely different than preeempt. Rik, do I
really have to explain the difference?

bye, Roman


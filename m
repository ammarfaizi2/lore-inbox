Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbTBNXuQ>; Fri, 14 Feb 2003 18:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268471AbTBNXt6>; Fri, 14 Feb 2003 18:49:58 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:26757 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268237AbTBNXrx>; Fri, 14 Feb 2003 18:47:53 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Feb 2003 16:04:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030214024046.GA18214@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50.0302141603220.988-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
 <20030214024046.GA18214@bjl1.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Jamie Lokier wrote:

> And when that's done you have some nice bonuses:
>
> 	- All event types are reported equally fast, and in a single
> 	  system call (read()).
>
> 	- The order in which events occurred is preserved.
> 	  (This is lost when you have to scan multiple queues).
>
> 	- Hierarchies of event sets of any kind are possible.
> 	  (epoll has solved the logical problems of this already).
>
> 	- Less code duplicated.
>
> 	- Adding new kinds of kernel events becomes _very_ simple.

Hmm ... using read() you'll lose the timeout capability, that IMHO is
pretty nice.




- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318786AbSHWMwS>; Fri, 23 Aug 2002 08:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318787AbSHWMwS>; Fri, 23 Aug 2002 08:52:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318786AbSHWMwR>; Fri, 23 Aug 2002 08:52:17 -0400
Date: Fri, 23 Aug 2002 08:56:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: ic@aleph1.net
cc: linux-kernel@vger.kernel.org
Subject: Re: process 0
In-Reply-To: <20020823121115.GA31534@aleph1.net>
Message-ID: <Pine.LNX.3.95.1020823085056.169A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002 ic@aleph1.net wrote:

> Hi.
> Maybe this is a little off topic, but does what is the real status of
> Process 0 (swapper) ?
> Some people keep telling me it doesn't exist, but on some kernel crashes
> I can see "process swapper (pid 0, process nr 0, ...)"
> 
> Can someone help me ?

Well, it kind-of exists. It's what the CPU does when there is nothing
else to do. Sort of like:

		for(;;)
                    schedule();

It's also where it 'goes' if init returns <grin>.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313991AbSDQBCh>; Tue, 16 Apr 2002 21:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313997AbSDQBAi>; Tue, 16 Apr 2002 21:00:38 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:3226 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313991AbSDQBAD>; Tue, 16 Apr 2002 21:00:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 16 Apr 2002 18:07:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <1019005044.1670.16.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0204161807030.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr 2002, Robert Love wrote:

> On Tue, 2002-04-16 at 20:49, David Mosberger wrote:
>
> > But since it's popular, I did measure it quickly on a relatively
> > slow (old) Itanium box: with 100Hz, the kernel compile was about
> > 0.6% faster than with 1024Hz (2.4.18 UP kernel).
>
> One question I have always had is why 1024 and not 1000 ?
>
> Because that is what Alpha does?  It seems to me there is no reason for
> a power-of-two timer value, and using 1024 vs 1000 just makes the math
> and rounding more difficult.

maybe because of the old TICK_SCALE macro ...



- Davide



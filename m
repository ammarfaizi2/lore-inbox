Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSA1MH3>; Mon, 28 Jan 2002 07:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSA1MHS>; Mon, 28 Jan 2002 07:07:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:27664 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287401AbSA1MHF>; Mon, 28 Jan 2002 07:07:05 -0500
Message-ID: <3C553EE3.4060202@evision-ventures.com>
Date: Mon, 28 Jan 2002 13:06:59 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C542FE6.7C56D6BD@mandrakesoft.com> <3C5439C1.6000305@evision-ventures.com> <3C543E86.7F0FA37A@gmx.net> <a31q91$upd$1@nell.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>Followup to:  <3C543E86.7F0FA37A@gmx.net>
>By author:    root <gunther.mayer@gmx.net>
>In newsgroup: linux.dev.kernel
>
>>You don't need a hub to have collisions.
>>
>>Duplex mismatch (i.e. one card in full-duplex, the other in half-duplex)
>>would just show 10-50 KByte/sec transfer rates typically.
>>
>>The card's statistics about "collisions" and "late collisions" would
>>positively prove if this is the case.
>>
>
>Not all cards correctly autoconfigure across a crossover cable (they
>should, but not all do).  When autoconfigure is screwed up, as you
>indicate above, things will be *VERY* messed up.
>

Well boys, I know about the ifconfig command, and I just don't see 
anything special there.
In esp. no collision indications. I would rather suspect, that there are 
maybe some IRQ sharing
problems with the driver, since this got changed as well. However I 
simple just didn't
have the time to narrow it down to this. (In esp. doing a recompile with 
just the blah_irq -> blash_irqsave
changes enabled.


>
>
>	-hpa
>




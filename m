Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQJaV4n>; Tue, 31 Oct 2000 16:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQJaV4d>; Tue, 31 Oct 2000 16:56:33 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65290 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130502AbQJaVz5>; Tue, 31 Oct 2000 16:55:57 -0500
Message-ID: <39FF3F0B.81A1EE13@timpanogas.org>
Date: Tue, 31 Oct 2000 14:52:11 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Pavel Machek wrote:
> 
> > > Excuse me, 857,000,000 instructions executed and 460,000,000
> > > context switches a second -- on a PII system at 350 Mhz. [...]
> 
> > That's more than one context switch per clock. I do not think so.
> > Really go and check those numbers.
> 
> yep, you cannot have 460 million context switches on that system,
> unless you have some Clintonesque definition for 'context switch' ;-)

The numbers don't lie.  You know where the code is.  You notice that
there is a version of
the kernel hand coded in assembly language.  You'l also noticed that
it's SMP and takes ZERO LOCKS during context switching, in fact, most of
the design is completely lockless.

Jeff

> 
>         Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

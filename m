Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbQJaWc3>; Tue, 31 Oct 2000 17:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbQJaWcT>; Tue, 31 Oct 2000 17:32:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:16651 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129318AbQJaWcL>; Tue, 31 Oct 2000 17:32:11 -0500
Message-ID: <39FF4773.CA06CB60@timpanogas.org>
Date: Tue, 31 Oct 2000 15:28:03 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010010380.16674-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> 
> > > > > Excuse me, 857,000,000 instructions executed and 460,000,000
> > > > > context switches a second -- on a PII system at 350 Mhz. [...]
> > >
> > > > That's more than one context switch per clock. I do not think so.
> > > > Really go and check those numbers.
> > >
> > > yep, you cannot have 460 million context switches on that system,
> > > unless you have some Clintonesque definition for 'context switch' ;-)
> >
> > The numbers don't lie. [...]
> 
> sure ;) I can do infinite context switches! You dont believe? See:
> 
>         #define schedule() do { } while (0)

Actually, I think the compiler would optimize this statement completely
out of the code.

Jeff

> 
> [there is a small restriction, should only be used in single-task
> systems.]
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

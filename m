Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265021AbSJOW0D>; Tue, 15 Oct 2002 18:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSJOWZm>; Tue, 15 Oct 2002 18:25:42 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:30624 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264804AbSJOWSP>; Tue, 15 Oct 2002 18:18:15 -0400
Message-Id: <5.1.0.14.2.20021015150438.051d52d8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 15:09:36 -0700
To: Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@redhat.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210152318150.26315-100000@localhost.localdo
 main>
References: <20021015.131929.103080718.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > "base handler" and "bottom half" all refer to an execution context,
> > and these days that means softirq.
>
>i think i agree with you.
>
>- we have 'top half' contexts, which are also called 'hardirqs'.
>
>- then we have 'bottom half' contexts, which are also called 'softirqs'.
>
>the fact that 'bottom halves' used to be an earlier concept that had a
>slightly different meaning from 'softirqs' for a limited amount of time
>does not remove from the meaningfulness of the naming itself. Today
>'bottom halves' and 'softirqs' are the same thing.

I still think we should rename _bh thing :). At least for consistent naming.
We have things like:
         in_softirq()
         do_softirq()
         sofirq_pending()
and
         local_bh_disable()
         local_bh_enable()

Anyway, I'll go ahead and shut up :). Most people didn't seem to like that 
proposal :(.

Max


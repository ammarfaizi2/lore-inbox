Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSJOVFZ>; Tue, 15 Oct 2002 17:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbSJOVEH>; Tue, 15 Oct 2002 17:04:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17819 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264838AbSJOVDZ>;
	Tue, 15 Oct 2002 17:03:25 -0400
Date: Tue, 15 Oct 2002 23:20:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: maxk@qualcomm.com, <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Rename _bh to _softirq
In-Reply-To: <20021015.131929.103080718.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210152318150.26315-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Oct 2002, David S. Miller wrote:

>    _bh is not a "base handler" it stands for "bottom half".
>
> "base handler" and "bottom half" all refer to an execution context,
> and these days that means softirq.

i think i agree with you.

- we have 'top half' contexts, which are also called 'hardirqs'.

- then we have 'bottom half' contexts, which are also called 'softirqs'.

the fact that 'bottom halves' used to be an earlier concept that had a
slightly different meaning from 'softirqs' for a limited amount of time
does not remove from the meaningfulness of the naming itself. Today
'bottom halves' and 'softirqs' are the same thing.

	Ingo


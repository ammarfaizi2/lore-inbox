Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264855AbSJOVKH>; Tue, 15 Oct 2002 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264828AbSJOVAu>; Tue, 15 Oct 2002 17:00:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44954 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264827AbSJOVA0>;
	Tue, 15 Oct 2002 17:00:26 -0400
Date: Tue, 15 Oct 2002 23:17:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, "David S. Miller" <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Rename _bh to _softirq
In-Reply-To: <5.1.0.14.2.20021015132636.01bdab40@mail1.qualcomm.com>
Message-ID: <Pine.LNX.4.44.0210152316500.26219-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Oct 2002, Maksim (Max) Krasnyanskiy wrote:

> >No, now it clearly means buffer head.
> Another point in favor of renaming :).
> 
> local_bh_disable() disables local _softirqs_ not "local buffer head".

they seldom occur in the same neighborhood - i've never mistaken buffer 
heads for bottom halves.

	Ingo


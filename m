Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319041AbSHMTPx>; Tue, 13 Aug 2002 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319042AbSHMTPx>; Tue, 13 Aug 2002 15:15:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28434 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319041AbSHMTPw>; Tue, 13 Aug 2002 15:15:52 -0400
Date: Tue, 13 Aug 2002 12:22:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <2009430000.1029265102@flay>
Message-ID: <Pine.LNX.4.44.0208131220350.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> 
> OK, I was being unclear, that's not really what I meant. If I may rephrase:
> I don't like the performance hit it gives on P3 standard SMP machines (not
> NUMA-Q) though it does work on there too, and there's no easy way for 
> people to disable it.

Well, it makes performance _so_ much better on a P4 that it's not even 
funny. It's basically a "P4 is unusable with SMP" without it.

		Linus


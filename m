Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310606AbSCPUZl>; Sat, 16 Mar 2002 15:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310598AbSCPUZb>; Sat, 16 Mar 2002 15:25:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3849 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310597AbSCPUZQ>; Sat, 16 Mar 2002 15:25:16 -0500
Date: Sat, 16 Mar 2002 12:23:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: <davidm@hpl.hp.com>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316130806.A21439@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161214380.31971-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> 
> AMD claims L1, L2 and with hammer an I/D split as well.

Oh, people have done L1/L2 TLB splits for a long time. The two-level TLB
exists in Athlon (and I think nexgen did it in the x86 space almost 10
years ago, and that's probably what got AMD into that game). Others have 
done it too.

And people have done split TLB's (I/D split is quite common, duplicated by
memory unit is getting so).

But multiple entries loaded at a time?

		Linus


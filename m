Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280368AbRKJBA1>; Fri, 9 Nov 2001 20:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRKJBAI>; Fri, 9 Nov 2001 20:00:08 -0500
Received: from modem-26.leopard.dialup.pol.co.uk ([217.135.144.26]:3332 "EHLO
	Mail.MemAlpha.cx") by vger.kernel.org with ESMTP id <S280364AbRKJBAD>;
	Fri, 9 Nov 2001 20:00:03 -0500
Posted-Date: Fri, 9 Nov 2001 22:35:17 GMT
Date: Fri, 9 Nov 2001 22:35:17 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111052029260.27086-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0111092229460.14996-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al, Linus.

>> For example, spreading out (and the inherent assumption of "slow
>> growth") might make sense for the root directory, and possibly for a
>> level below that. It almost certainly does _not_ make sense for a
>> directory created four levels down.

> Depends on the naming scheme used by admin, for one thing. Linus, I
> seriously think that getting the real-life traces to play with would
> be a Good Thing(tm) - at least that would allow to test how well
> would heuristics of that kind do.

Let's be realistic here - you two seem to be talking at cross-purposes,
and that will get us precicely nowhere.

Linus:	If I'm right, your "root directory" refers to the root
	directory of a particular partition. Correct?

Al:	If I'm right, your "root directory" refers to the root
	directory of the entire VFS tree. Correct?

If you can try reading each other's comments with both of the above
definitions, I think you'll see why you're clearly drifting apart from
each other in your comments.

Best wishes from Riley.


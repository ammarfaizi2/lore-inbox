Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSBDJG0>; Mon, 4 Feb 2002 04:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSBDJGR>; Mon, 4 Feb 2002 04:06:17 -0500
Received: from mail.scram.de ([195.226.127.117]:49604 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S287868AbSBDJGK>;
	Mon, 4 Feb 2002 04:06:10 -0500
Date: Mon, 4 Feb 2002 10:06:02 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
To: Sten <sten@blinkenlights.nl>
cc: <linux-kernel@vger.kernel.org>,
        HP900 PARISC mailing list 
	<parisc-linux@lists.parisc-linux.org>
Subject: Re: IPv6 Sparc64
In-Reply-To: <Pine.LNX.4.44-Blink.0202040829140.19625-100000@deepthought.blinkenlights.nl>
Message-ID: <Pine.NEB.4.33.0202041002120.2571-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sten,

> I have been trying to get ipv6 to work
> on sparc64/kernel 2.4 but it looks like it
> is broken somewhere in the kernel.
> I was wondering if this was a known problem.

> [root@towel ip]# ping6 ::1
> PING ::1(::1) from ::1 : 56 data bytes

It's the same on PARISC. However, on PARISC, although ping6 doesn't work,
telnet etc do work, as well as pinging the PARISC box from an Intel or
Alpha machine.

For now, i assume there might be an endianess issue in net/ipv6/raw.c
somewhere... Has anyone tested IPv6 on m68k?

Cheers,
Jochen


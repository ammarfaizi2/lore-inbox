Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTBDT5p>; Tue, 4 Feb 2003 14:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTBDT5p>; Tue, 4 Feb 2003 14:57:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1946 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267436AbTBDT5o>; Tue, 4 Feb 2003 14:57:44 -0500
Date: Tue, 4 Feb 2003 15:10:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Fiona Sou-Yee Wong <wongfs@cs.ucdavis.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: disabling nagle
In-Reply-To: <Pine.LNX.4.44.0302041138070.2629-100000@pc6.cs.ucdavis.edu>
Message-ID: <Pine.LNX.3.95.1030204150721.12306A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Fiona Sou-Yee Wong wrote:

> Hi
> 
> I have kernel version 2.4.18 and I was looking for a patch to have the 
> option to disable NAGLE's algorithm.
> Is there a patch available for kernels 2.4 and greater and if not, what 
> other options do I have?
> 
> Thanks
> Fiona

Just turn it off in your program:

int on = 1;
setsockopt(s, SOL_TCP, TCP_NODELAY, &on, sizeof(on));


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



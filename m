Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSEIRCY>; Thu, 9 May 2002 13:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313914AbSEIRCX>; Thu, 9 May 2002 13:02:23 -0400
Received: from pD955F2C1.dip.t-dialin.net ([217.85.242.193]:565 "EHLO
	extern.linux-systeme.org") by vger.kernel.org with ESMTP
	id <S313907AbSEIRCW>; Thu, 9 May 2002 13:02:22 -0400
Date: Thu, 9 May 2002 19:02:16 +0200 (MET DST)
From: mcp@linux-systeme.de
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with param.h/time.h/timex.h
In-Reply-To: <Pine.NEB.4.44.0205091841490.19321-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.3.96.1020509190131.23305B-100000@fps>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adriann,

> The compilation output already shows that HZ wasn't set while compiling
> panic.c (there's none of your "Just an info" messages).
> Most likely you've forgotten to add a
>   #include <linux/config.h>
> to your modified param.h and therefore none of your custom CONFIG_*HZ is
> defined when the compiler goes through param.h.

Thats it Adrian!! :-) Many thanks!

Kind regards,
	Marc


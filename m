Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278549AbRKHVdj>; Thu, 8 Nov 2001 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRKHVde>; Thu, 8 Nov 2001 16:33:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278549AbRKHVcp>; Thu, 8 Nov 2001 16:32:45 -0500
Date: Thu, 8 Nov 2001 16:32:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Chandler <chandler@grammatech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <3BEABE11.AFF00CF0@grammatech.com>
Message-ID: <Pine.LNX.3.95.1011108162912.239A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, David Chandler wrote:

> Dick,
> 
> You're right that the one-liner below may not necessarily produce a seg
> fault, but shouldn't it terminate normally if it doesn't?  After all,
> the program just *reads*.  Hanging does not seem to be an option!
> 
You may want to see if any deliberate seg-fault actually gets
delivered. Try to read *(0).  If that works (seg-faults), then
there may be a problem with some boundary condition on paging.

I can't duplicate the problem here. You can also try to trace
the code execution to see if it falls into some user-space loop.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



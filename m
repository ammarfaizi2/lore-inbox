Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265203AbSKEUeO>; Tue, 5 Nov 2002 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265204AbSKEUeO>; Tue, 5 Nov 2002 15:34:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265203AbSKEUeN>; Tue, 5 Nov 2002 15:34:13 -0500
Date: Tue, 5 Nov 2002 15:41:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Willy Tarreau <willy@w.ods.org>, Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
In-Reply-To: <1036529824.6757.44.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1021105153853.734C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Nov 2002, Alan Cox wrote:

> On Tue, 2002-11-05 at 20:23, Richard B. Johnson wrote:
> > Hey, look. I can only warn. You do what you want. As far as I'm
> > concerned support stopped at Linux 2.4.19 when poll got trashed.
> > Nobody can use 2.4.19 or probably anything later unless they have
> > powerful CPUs that can spin with 1000 SIGPOLL signals per second.
> 
> My 486SLC33 (running at 8MHz on battery mode) doesn't believe you.
> 

Enable SIGPOLL on STDIN_FILENO and connect from the network as previously
shown. You will get 100% CPU time on the task with this enabled.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280809AbRKBTwA>; Fri, 2 Nov 2001 14:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280811AbRKBTvl>; Fri, 2 Nov 2001 14:51:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280809AbRKBTve>; Fri, 2 Nov 2001 14:51:34 -0500
Date: Fri, 2 Nov 2001 14:51:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ian Stirling <root@mauve.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Diagnosing dead mice.
In-Reply-To: <200111021921.TAA00792@mauve.demon.co.uk>
Message-ID: <Pine.LNX.3.95.1011102144445.257A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Ian Stirling wrote:

> I've recently bought a new PS/2 scrolmouse, for the princely sum of $2.
> 
> It doesn't work when plugged into my laptop, and occasionally 
> generates "unknown scancode" and random keys when used.
> 
> It's a "Browser Mouse" FCC ID: IOWCM-B700
> 
> Is there any logging tool I can use to debug PS2 problems?

In the early '80s, IBM published an official report about cleaning
mice balls. Dead mice are a different problem, though, because
dirty mice balls are not known to be fatal. ;^)

od -xa /dev/mouse should show you the mouse-stuff.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSLDQsK>; Wed, 4 Dec 2002 11:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbSLDQsJ>; Wed, 4 Dec 2002 11:48:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22406 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266987AbSLDQsI>; Wed, 4 Dec 2002 11:48:08 -0500
Date: Wed, 4 Dec 2002 11:58:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Waterhouse <mwaterho@sgi.com>
cc: linux-kernel@vger.kernel.org, mw@sgi.com
Subject: Re: Kernel Error : Can you tell me whats causing it?
In-Reply-To: <064401c29bb4$1b7d99f0$ed1b0f86@dfksystems.com>
Message-ID: <Pine.LNX.3.95.1021204115202.29419A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002, Mark Waterhouse wrote:

> Hi all
> 
> I've recently bought a new machine (from ebay!) and have installed RedHat
> 8.0 on it.
> 
> Its running Kernel-2.4.18-14 and was installed via RPM.
> 
> However, when running a very simple perl script, I get a segmentation fault
> and the following lines appear in syslog (at bottom of mail).
> The machine is doing nothing fancy .... its running a dhcp-client and
> sendmail.
> 
> Is there something in the error messages which indicates where the fault
> maybe?
> 
> Any help would be greatly appreciated.
> Thanks
> Mark Waterhouse
> 
[SNIPPED...]
Many times when the kernel forks another process, it crashes. It
looks like you have one (or more) of the following:

(1)	Bad RAM.
(2)	Over Clocked.
(3)	CPU too hot (wrong heatsink).
(4)	Bad board (why somebody got rid of it was on ebay).

Hopefully, it isn't (4). I got a Tyan board off from ebay once.
It was the last time I did that. $135 down the drain. It would
boot DOS/Windows/Linux, then stop.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America



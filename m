Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293599AbSBZVL6>; Tue, 26 Feb 2002 16:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293600AbSBZVLs>; Tue, 26 Feb 2002 16:11:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35979 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293599AbSBZVL3>; Tue, 26 Feb 2002 16:11:29 -0500
Date: Tue, 26 Feb 2002 16:14:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.4.44.0202261218080.1544-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.3.95.1020226161330.7314A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Davide Libenzi wrote:
> 
> In 2.5 yield() maps to sys_sched_yield(). You can handle it in the same
> way in your includes if version <= 2.4.

It's not exported as well as not defined in a header! It results in
an undefined symbol in the module.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321


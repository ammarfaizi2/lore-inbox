Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRCUNzv>; Wed, 21 Mar 2001 08:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131420AbRCUNzm>; Wed, 21 Mar 2001 08:55:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131430AbRCUNzY>; Wed, 21 Mar 2001 08:55:24 -0500
Date: Wed, 21 Mar 2001 08:54:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Antwerpen, Oliver" <Antwerpen@netsquare.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to provoke kernel panic
In-Reply-To: <9DD550E9A9B0D411A16700D0B7E38BA4E67E@POL-EML-SRV1>
Message-ID: <Pine.LNX.3.95.1010321085047.138A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Antwerpen, Oliver wrote:

> Moin,
> 
> Could someone kindly tell me how to provoke a kernel panic? I need to do so
> for testing some applications regarding system crash awareness.
> 
> Olli
> -

If you want a real crash, rather than an induced panic(), just:

	`cp /dev/zero /dev/mem`

.... from the root account.


This will demonstrate that most 'crash detector' programs are
worthless (including some watchdog timers).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



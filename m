Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRCENaF>; Mon, 5 Mar 2001 08:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCEN3z>; Mon, 5 Mar 2001 08:29:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9858 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129281AbRCEN3l>; Mon, 5 Mar 2001 08:29:41 -0500
Date: Mon, 5 Mar 2001 08:29:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Possible CPU time reporting V2.4.1
Message-ID: <Pine.LNX.3.95.1010305082152.8615A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following program:

main()
{
    for(;;)
        sleep(1);
}

should use very little CPU time. When it is first started, it doesn't
show anything being used. However, run this over a weekend! It will
show up in `top` as consuming 100% of the CPU time after a few days.

The machine seems as lively as ever so it's likely not using any
significant CPU time. It's probably some reporting/accounting problem.

I have tried this now on two 2.4.1 machines. Both are Pentium III,
600 MHz (coppermine), SMP.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



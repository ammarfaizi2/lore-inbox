Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265344AbRGBRBK>; Mon, 2 Jul 2001 13:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265342AbRGBRAv>; Mon, 2 Jul 2001 13:00:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265341AbRGBRAi>; Mon, 2 Jul 2001 13:00:38 -0400
Date: Mon, 2 Jul 2001 13:00:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: kernel@ddx.a2000.nu
cc: linux-kernel@vger.kernel.org, Enforcer <enforcer@ddx.a2000.nu>
Subject: Re: Strange errors in /var/log/messages
In-Reply-To: <Pine.LNX.4.30.0107021800410.5490-100000@ddx.a2000.nu>
Message-ID: <Pine.LNX.3.95.1010702125419.5216A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001 kernel@ddx.a2000.nu wrote:

> Hi!
> 
> I'm running RedHat 7.0 with all official RH patches applied. The kernel I
> currently run fow a few days is 2.2.19-7.0.8
> I run the pre-compiled kernel of RH. Suddenly I the following messages:
> 
> Jul  2 15:12:16 gateway SERVER[1240]: Dispatch_input: bad request line
> 'BBXXXXXXXXXXXXXXXXXX%.176u%3
> 00$nsecurity.%301$n%302$n%.192u%303$n\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220111F\200\2111f\2111\211C\211]C\211]K\211M\215M\2001\211ECf
> 
> <CUT>
> 
> Jul  2 15:12:53 gateway SERVER[1152]: Dispatch_input: bad request line
> 'BBTUVWXXXXXXXXXXXXXXXXXX%.20u%30
> 0$n%.166u%301$n%302$n%.192u%303$n\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22
> 0\220\220\220\220\220111F\200\2111f\2111\211C\211]C\211]K\211M\215M\2001\211ECf\211
> 
> This continued for about half an hour. Then it stopped. What's going on
> here??
> 
> -

I think you just got 'rooted'. Look at /etc/inetd.conf (if it exists
on your system, the xinetd is more robust). It may have a new entry
on its last line providing a root shell to anybody. This looks somewhat
like an attack shown by CERN about 6 to 12 months ago.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



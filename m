Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129474AbQKGVhC>; Tue, 7 Nov 2000 16:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQKGVgx>; Tue, 7 Nov 2000 16:36:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129474AbQKGVgp>; Tue, 7 Nov 2000 16:36:45 -0500
Date: Tue, 7 Nov 2000 16:36:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Lang <david.lang@digitalinsight.com>
cc: Tim Riker <Tim@Rikers.org>, Jes Sorensen <jes@linuxcare.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <Pine.LNX.4.21.0011071405380.8417-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.3.95.1001107163405.2798A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, David Lang wrote:

> Dick Johnson,
>   earlier in the discussion there was a post of the 'incompatabilities'
> that were noted and one of the replies to that listed several c99 tools
> available to do the same job with the c99 syntax, so there are at least
> some cases where things are done the gcc-only way instead of the c99 way.
> 
> nobody is suggesting that the kernel loose functionality to achieve
> portability, the suggestion was mearly to be portable where possible and
> clearly mark the places where gcc-isms are used and why.
> 
> David Lang

Sure, but certain c99 things, like `pragma` tend to be global to
a file so they look like they might work, but then tend to have
other unwanted side effects (pack comes to mind).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

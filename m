Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbQJaXUZ>; Tue, 31 Oct 2000 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130799AbQJaXUP>; Tue, 31 Oct 2000 18:20:15 -0500
Received: from zeus.kernel.org ([209.10.41.242]:11274 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130745AbQJaXUG>;
	Tue, 31 Oct 2000 18:20:06 -0500
Message-ID: <39FF5259.822F28FF@timpanogas.org>
Date: Tue, 31 Oct 2000 16:14:33 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Andi Kleen <ak@suse.de>, mingo@elte.hu, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.3.95.1001031174047.165A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Richard B. Johnson" wrote:
> 

Dick,

In NetWare this:

> 
> One could create a 'kernel' that does:
>         for(;;)
>         {
>           proc0();
>           proc1();
>           proc2();
>           proc3();
>           etc();
>         }

would be coded like this (no C compiler):

proc0:

proc1:

proc2:

proc3:

etc:

label:
     jmp  proc0


I just avoided 5 x 20 bytes of pushes and pops on the stack ad optimized
for a simple fall through case.  

:-)

Jeff

> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRAYRmh>; Thu, 25 Jan 2001 12:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRAYRm1>; Thu, 25 Jan 2001 12:42:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132027AbRAYRmJ>; Thu, 25 Jan 2001 12:42:09 -0500
Date: Thu, 25 Jan 2001 12:41:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pete Zaitcev <zaitcev@metabyte.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: patchlet for cs46xx
In-Reply-To: <3A70588B.4692D937@metabyte.com>
Message-ID: <Pine.LNX.3.95.1010125123928.9456A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Pete Zaitcev wrote:

> Sorry for the nitpicking, bust since 2.4 is now "stable"...
> -- Pete
> 
[SNIPPED...]
>From what I tested, copy_to/from_user, now seg-faults the caller directly.
If the function returns, it worked. Therefore you will never get a
chance to return -EFAULT.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

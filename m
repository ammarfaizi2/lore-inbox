Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLGTJk>; Thu, 7 Dec 2000 14:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLGTJ3>; Thu, 7 Dec 2000 14:09:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129255AbQLGTJR>; Thu, 7 Dec 2000 14:09:17 -0500
Date: Thu, 7 Dec 2000 13:38:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test9 Root no longer permitted to format floppies?
In-Reply-To: <Pine.LNX.4.21.0012071802050.2182-100000@penguin.homenet>
Message-ID: <Pine.LNX.3.95.1001207133755.1386A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Tigran Aivazian wrote:

> there was an issue with floppy ioctls and permission checks in block
> device ->open routine recently. Just use test12-pre7 or other sufficiently
> recent kernel and it will work.
> 
> If you _do_ want to know what's going on -- look for the thread where I
> reported that floppies can't me mounted readonly, then AV proposed the
> fix, then it turned out that Alain Knaff forgot to put his name in the
> MAINTAINERS file so we didn't tell him about the fix and it apparently
> broke some userspace tools. Later on, it was fixed in a way that makes
> everyone happy.
> 
> Regards,
> Tigran
> 

Okay. Looks like someone is on top of this.


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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK3NzP>; Thu, 30 Nov 2000 08:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129267AbQK3NzG>; Thu, 30 Nov 2000 08:55:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S129183AbQK3Ny4>; Thu, 30 Nov 2000 08:54:56 -0500
Date: Thu, 30 Nov 2000 08:24:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steven Van Acker <deepstar@ulyssis.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 directory size bug (?)
In-Reply-To: <Pine.LNX.4.21.0011300453200.31229-100000@ace.ulyssis.org>
Message-ID: <Pine.LNX.3.95.1001130081717.723A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, Steven Van Acker wrote:

> It this is a known thing, please don't kill me...
> Hmm, gonna try to follow the REPORTING-BUGS file here...

It is not a bug. Directory entries increase in size as allocation
units are added to handle directory entries. Once allocated, they
are not deallocated until the directory is removed.

This is actually a feature. The directory does not get truncated.

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

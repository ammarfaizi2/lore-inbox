Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136932AbREJVnR>; Thu, 10 May 2001 17:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136954AbREJVnI>; Thu, 10 May 2001 17:43:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:45184 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136932AbREJVmv>; Thu, 10 May 2001 17:42:51 -0400
Date: Thu, 10 May 2001 17:42:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Not a typewriter
Message-ID: <Pine.LNX.3.95.1010510173138.29690A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that my favorite "errno" has now gotten trashed by
the newer 'C' runtime libraries.

ENOTTY has been for ages, "Not a typewriter".
It's now been changed to "Inappropriate ioctl for device".

Methinks that this means that ../linux/include/asm/errno.h now needs
to be updated:


-#define	ENOTTY		25	/* Not a typewriter */
+#define	ENOTTY		25	/* Inappropriate ioctl for device 
*/

None of these strings are in the kernel, but the headers probably should
show the "latest standard".


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



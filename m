Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277598AbRJRNPR>; Thu, 18 Oct 2001 09:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277626AbRJRNPH>; Thu, 18 Oct 2001 09:15:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39553 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277598AbRJRNO4>; Thu, 18 Oct 2001 09:14:56 -0400
Date: Thu, 18 Oct 2001 09:15:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Non-GPL modules
Message-ID: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From time-to-time, I've asked that certain things be allowed
within the kernel such as, most recently, denying a raw write
to a mounted file-system. Such things have been opposed because,
as I have been told, "Policy is not allowed within the kernel...".

Well, with the current GPL code-only fiasco, this is Policy being
enforced by the kernel.

It won't be long before we get:

Script started on Thu Oct 18 08:44:44 2001
# gcc -o applic xxx.c
# ./applic
Kernel panic
Non GPL application pollution of the Linux environment
Application name = ./applic
 Virtual address = 0x8048528
   Stack address = 0xbffff72c
             PID = 32636
System halted

I can understand not wanting to take any responsibility for
some binary-only module when attempting to find a kernel
problem. However, denying the use of non GPL modules is
not the way. As a developer of many modules, I can certainly
add the required object(s) during development and bypass the
current policy. In fact, since the source code of `insmod`
is available, it won't be long before any checks put there
are eliminated. 

No publicly-traded commercial hardware company is going to
disclose the inner workings of proprietary hardware without
risking a stockholder's lawsuit. For this reason, there will
always be proprietary hardware and proprietary software to
interface with it. If Linux doesn't allow for such a proprietary
interface then Linux will not be used. It's just that simple.

Even publicly-traded commercial software companies face the
same challenge from their stockholders. The intellectual
property that they have developed must be kept secret from
their competition. Otherwise, one company spends millions
to develop a product only to have another start-up deliver
the same product at a cheaper price with no up-front development
cost because they would use the intellectual property of the
developer.

In the business world, something as simple as puts("Hello World!");
MUST be kept a trade secret. If it was written by an employee
in the context of his or her job, the company's stockholders owns
that line of code so no employee, even the President, is allowed
to give it away.

If Linux intends to become the mainstay for commercial enterprise
then the developers have to accommodate the "impure" commercial
practices that exist in this little cruel world.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRJIURX>; Tue, 9 Oct 2001 16:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277952AbRJIURN>; Tue, 9 Oct 2001 16:17:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10368 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277949AbRJIURA>; Tue, 9 Oct 2001 16:17:00 -0400
Date: Tue, 9 Oct 2001 16:16:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kitwor <kitwor@kki.net.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: old exploit works!!!
In-Reply-To: <000a01c150fb$6549e700$6400a8c0@czesio>
Message-ID: <Pine.LNX.3.95.1011009161252.4052A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erm. Doesn't work. Just creates a non-root shell with a bad
environment. It says "Bug exploited successfully", but it's
simply confused.

Script started on Tue Oct  9 16:07:45 2001
$ whoami
rjohnson
$ gcc -o xxx c.c
$ ./xxx
Bug exploited successfully.
bash$ vi /etc/passwd
This termcap entry lacks the :cm=: capability
This termcap entry lacks the :ce=: capability
"/etc/passwd" [READONLY] 32 lines, 1594 chars
:1
root:Deleted:0:0:System Administration:/root:/bin/bash
:w!
Can't write to "/etc/passwd" -- NOT WRITTEN
:q
bash$ exit
exit
$ exit
exit

Script done on Tue Oct  9 16:08:54 2001
On Tue, 9 Oct 2001, Kitwor wrote:

> Old exploit which works on kernels up to 2.2.18 (itr doesn't work on 2.2.19)
> works on 2.4.9!!
> I attach that exploit.
> 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



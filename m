Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTK3XwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTK3XwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:52:14 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:1488 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261326AbTK3XwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:52:12 -0500
Message-ID: <3FCA830F.7080103@free.fr>
Date: Mon, 01 Dec 2003 00:53:51 +0100
From: =?ISO-8859-2?Q?Ga=EBl_Deest?= <GUtopiste@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11, 2.6.0-test9 and gdb 6.0
References: <20031130214025.GO2935@mail.muni.cz>
In-Reply-To: <20031130214025.GO2935@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:

>Hello,
>
>is there any issue about using gdb with pthreads under 2.6.0-test9+ kernels?
>
>With 2.6.0-test11 I got message while du next over a function that creates some
>threads:
>
>Program received signal SIG32, Real-time event 32.
>__pthread_sigsuspend (set=0xbffff6d0)
>   at ../linuxthreads/sysdeps/unix/sysv/linux/pt-sigsuspend.c:5656	
>   ../linuxthreads/sysdeps/unix/sysv/linux/pt-sigsuspend.c: No such file or directory.
>   in ../linuxthreads/sysdeps/unix/sysv/linux/pt-sigsuspend.c
>(gdb)
>
>With 2.6.0-test9 I got a message about gdb cannot read thread registers.
>
>With 2.4.x series it is ok. Is it a bug in ptrace in kernel or a bug in gdb?
>
>  
>
I've got exactly the same problem...


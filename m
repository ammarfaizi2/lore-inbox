Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291205AbSBLVWM>; Tue, 12 Feb 2002 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291204AbSBLVWC>; Tue, 12 Feb 2002 16:22:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27524 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291193AbSBLVU0>; Tue, 12 Feb 2002 16:20:26 -0500
Date: Tue, 12 Feb 2002 16:23:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bob Miller <rem@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.4 Can't use spin_lock_* with wait_queue_head_t object.
In-Reply-To: <20020212120100.A7619@doc.pdx.osdl.net>
Message-ID: <Pine.LNX.3.95.1020212162231.10673A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Bob Miller wrote:

> There is code in sched.c that uses the spin_lock_* interfaces to acquire and
> release the lock in the wait_queue_head_t embedded in the struct completion.
> 
Isn't it just that the spin_lock wasn't initialized at the start?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



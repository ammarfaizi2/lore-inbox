Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUAEPpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAEPpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:45:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21120 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265167AbUAEPoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:44:02 -0500
Date: Mon, 5 Jan 2004 10:44:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Biplab Sarkar <xmp100@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: system speed
In-Reply-To: <20040105151938.92587.qmail@web20023.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0401051037340.5969@chaos>
References: <20040105151938.92587.qmail@web20023.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Biplab Sarkar wrote:

> Hi,
>
>  I am new to this list. I have a question would be
> greatful if anyone answers it.
>
> I have observed that my linux PC (Celeron-633Mhz) runs
> significantly slow after I have installed Mandrake-9.2
> which has kernel (2.4.22). My earlier kernel was
> 2.2.22 (mandrake 7.2). The speed seems to be slow
> right from the bootup sequence.
>
> I have also observed that if I do an abnormal shutdown
> of the system (by pressing the reset button of the
> computer) the system speeds up significantly somewhat
> comparable to my old kernel speed. Right from the
> bootup sequence every thing runs fast.
>
> I have also observed that the CPU utilization is very
> high for case when the I try a normal shutdown
> followed by a bootup. I could not see any single
> process that would be hogging the CPU. It seems like
> any process that gets the CPU likes to hog the CPU.
>
>
> Any idea what is it that is causing the system to run
> faster when we have an abnormal shutdown of the
> system?
>
> Thanks,
> Biplab

After you hit the reset button, the BIOS will perform a cold-boot
which means everything gets initialized from scratch. Aside from
the file-system rebuild that occurs when you improperly shut-down
a system, there should be no additional history and, therefore,
no difference in performance before and after your shutdown sequence.

If you execute `top` you should clearly see what process, if any,
is hogging the CPU.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbUCRRBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUCRRBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:01:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19854 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262764AbUCRRBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:01:34 -0500
Date: Thu, 18 Mar 2004 11:59:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Justin Piszcz <jpiszcz@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
In-Reply-To: <Law10-F95ihL5C2Skqk00028182@hotmail.com>
Message-ID: <Pine.LNX.4.53.0403181149580.29318@chaos>
References: <Law10-F95ihL5C2Skqk00028182@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Justin Piszcz wrote:
[SNIPPED...]
>
> My question is, what are the advantages vs disadvantages in updating your
> CPU's microcode?
>
> Is it worth it?

Remember the CPU with the f00f bug? How about the FP unit bug?
With ucode updates, those bugs can be fixed with zero overhead,
just an additional second or two of boot-time.

>
> Does it matter what type of Intel CPU you have?
>
Of course, some don't have WCS (Writable control-store) and
therefore can't be updated.

> Do some CPU's benefit more than others for microcode updates?
>

Only the broken ones.

>
> Can anyone explain reasons to or not to update the CPU microcode?
>

"If it ain't broke, don't fix it.".... But there are some people
who want the "latest and greatest" even though there is no performance
change at all.

When new CPUs hit the market there are some "immature features", i.e.,
BUGS. With a WCS, micro-code work-arounds can be provided so that
the CPU doesn't have to be thrown away. If you use the wrong micro-
code, perhaps the "latest and greatest", you may actually break
the CPU because the work-arounds go away.

Review the stuff on http://www.x86.org. Even though it's slanted
far to the left, there is some good information there.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



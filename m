Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbTCUU6O>; Fri, 21 Mar 2003 15:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTCUU5O>; Fri, 21 Mar 2003 15:57:14 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:34277 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S262727AbTCUU4b>; Fri, 21 Mar 2003 15:56:31 -0500
Subject: Re: Linux 2.5.65-ac2
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200303211741.h2LHfPn00366@devserv.devel.redhat.com>
References: <200303211741.h2LHfPn00366@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 21 Mar 2003 14:03:10 -0700
Message-Id: <1048280590.2545.14.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 10:41, Alan Cox wrote:
> Linux 2.5.65-ac2

On boot of 2.5.65-ac2, I got this (taken down by hand)

checking TSC synchronization across 2 CPUs:
divide error: 0000
CPU	0
[register stuff not transcribed]
Call Trace:

release_console_sem+0xa0
init+0x53
init+0x0
kernel_thread_help+0x5

I can write down the register stuff if needed.

I had previously booted with MORSE_PANICS enabled, and
the machine also either oopsed or panicked on boot.
I saw something about morse_panics in that trace, which was
very long, so I rebuilt -ac2 without MORSE_PANICS and got
the above.

The machine is dual PIII, kernel SMP, PREEMPT.
I can provide the .config if needed.

Steven





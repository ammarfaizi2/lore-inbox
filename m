Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWIWT6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWIWT6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWIWT6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:58:49 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:697 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751512AbWIWT6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:58:49 -0400
Date: Sat, 23 Sep 2006 21:58:32 +0200
From: Voluspa <lista1@comhem.se>
To: Daniel Walker <dwalker@mvista.com>
Cc: brugolsky@telemetry-investments.com, mingo@elte.hu, pavel@suse.cz,
       akpm@osdl.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060923215832.03b1dac5@loke.fish.not>
In-Reply-To: <1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <20060923041746.2b9b7e1f@loke.fish.not>
	<1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 11:09:26 -0700 Daniel Walker wrote:
> On Sat, 2006-09-23 at 04:17 +0200, Voluspa wrote:
[...]
> It seems like you don't need all of 2.6.18-rt3 , you just want dynamic
> tick .. You can obtain just the HRT/dynamic tick patch from here,
> 
> http://www.tglx.de/projects/hrtimers/2.6.18/

I'm not good enough at C yet to immediately see what needs fixing. And
the hour is too late anyways:

  BUILD   arch/x86_64/boot/bzImage
Root device is (3, 2)
Boot sector 512 bytes.
Setup is 4709 bytes.
System is 1461 kB
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
[usual ACPI section mismatch warning deleted]
WARNING: "monotonic_clock" [drivers/char/hangcheck-timer.ko] undefined!
WARNING: "hrtimer_stop_sched_tick" [drivers/acpi/processor.ko] undefined!
WARNING: "hrtimer_restart_sched_tick" [drivers/acpi/processor.ko] undefined!
CC     arch/x86_64/kernel/cpufreq/powernow-k8.mod.o
LD [M] arch/x86_64/kernel/cpufreq/powernow-k8.ko

Mvh
Mats Johannesson

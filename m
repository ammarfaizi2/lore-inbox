Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268898AbTGORCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268938AbTGORCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:02:41 -0400
Received: from [66.170.231.25] ([66.170.231.25]:25728 "EHLO
	euphrates.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id S268898AbTGORCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:02:38 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 - cpu_freg sysfs nodes?
References: <m34r1n3e93.fsf@euphrates.ncsl.nist.gov>
	<20030715164251.GA2623@inferi.kami.home>
From: ian.soboroff@nist.gov
Date: Tue, 15 Jul 2003 14:17:23 -0400
In-Reply-To: <20030715164251.GA2623@inferi.kami.home> (Mattia Dongili's
 message of "Tue, 15 Jul 2003 18:42:51 +0200")
Message-ID: <m3d6gb1wp8.fsf@euphrates.ncsl.nist.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <dongili@supereva.it> writes:

> find /sys -iname 'cpu*'
>
> /sys/firmware/acpi/namespace/ACPI/CPU0
> /sys/devices/system/cpu
> /sys/devices/system/cpu/cpu0
> /sys/devices/system/cpu/cpu0/cpufreq
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq

If this is the right place to look, the Documentation/cpu-freq needs
some updating.

But this still isn't it...

# find /sys -iname 'cpu*'
/sys/devices/system/cpu
/sys/devices/system/cpu/cpu0
/sys/cdev/major/cpu!cpuid
/sys/cdev/major/cpu!msr

:-(
Ian


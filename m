Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTBOXpm>; Sat, 15 Feb 2003 18:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBOXpm>; Sat, 15 Feb 2003 18:45:42 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:52970 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S264822AbTBOXpl>; Sat, 15 Feb 2003 18:45:41 -0500
Date: Sun, 16 Feb 2003 00:55:37 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Arador <diegocg@teleline.es>
Subject: Re: 2.5.61 SMP -> solid lockup
In-Reply-To: <Pine.LNX.4.33.0302152051130.6495-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0302160046280.7624-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Tim Schmielau wrote:

> 2.4.61 on a dual PIII will lock up hard in less than 5 minutes for me.
> No output on the console. CONFIG_PREEMPT makes no difference.
> UP works, with and without CONFIG_PREEMPT, CONFIG_X86_LOCAL_APIC,
> CONFIG_X86_IO_APIC. My full .config is below.
>
> The problem was introduced between 2.5.59 and 2.5.60. Unfortunately,
> I don't have the 2.5.59-bk patches to do a further binary search.

Thanks to Diego Calleja, who provided me with a working .config,
I found that turning off ACPI fixes it.

Since I enabled it unintentionally, anyways, I'm happy again and will
just enter this case into Bugzilla and forget about it.

Thanks again,
Tim



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283871AbRLEJ37>; Wed, 5 Dec 2001 04:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283880AbRLEJ3u>; Wed, 5 Dec 2001 04:29:50 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:21943 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283871AbRLEJ3g>; Wed, 5 Dec 2001 04:29:36 -0500
Date: Wed, 5 Dec 2001 11:33:21 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: APIC Error when doing apic_pm_suspend
Message-ID: <Pine.LNX.4.33.0112051123500.18928-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get an APIC error 0x40 when resuming from an apm -s. If i'm correct
that would be an illegal register access wouldn't it? I tried putting
enter/exit printks in the apic_pm_resume/suspend functions and it showed
that both returned before the APIC error printk. Is there anyway of finding out
which register access it was? I "thought" it would be one of the
apic_writes in the pm functions but looks like i might be wrong.

The kernel is compiled with local APIC and gets detected and enabled on
boot (UP machine).

Thanks,
	Zwane Mwaikambo



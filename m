Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTBVNdZ>; Sat, 22 Feb 2003 08:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267898AbTBVNdZ>; Sat, 22 Feb 2003 08:33:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:896 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S267065AbTBVNdZ>;
	Sat, 22 Feb 2003 08:33:25 -0500
Date: Sat, 22 Feb 2003 08:43:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Module loading on demand
Message-ID: <Pine.LNX.4.44.0302220835590.13234-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I note that with "new modules" modules no longer seem to load as needed 
but must be loaded by hand or explicitly in modprobe.conf.

I have just been bitten by this trying to build a kernel (loop needed to 
be loaded by hand) and using a VFAT format ZIP drive partition, where 
mount didn't load the vfat module.

Is there some trick to making modules useful again?

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.



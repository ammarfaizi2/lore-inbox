Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273754AbRIXDIx>; Sun, 23 Sep 2001 23:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273755AbRIXDIn>; Sun, 23 Sep 2001 23:08:43 -0400
Received: from ool-18be1462.dyn.optonline.net ([24.190.20.98]:23564 "EHLO
	moat3225.research.att.com") by vger.kernel.org with ESMTP
	id <S273754AbRIXDIi>; Sun, 23 Sep 2001 23:08:38 -0400
Date: Sun, 23 Sep 2001 23:04:56 -0400 (EDT)
From: "D. Sen" <dsen@nospam_homemail.com.research.att.com>
To: <linux-kernel@vger.kernel.org>
Subject: apm broken in 2.4.10? (on IBM Thinkpad T21)
Message-ID: <Pine.LNX.4.30.0109232300180.16596-100000@moat3225.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just upgraded to 2.4.10 from 2.4.7. I didnt change any of the APM
configurations from my 2.4.7 configuration. Yet, everytime I tried to
suspend the machine, I got messages saying that APM was not built into the
kernel.

Finally, I replaced arch/i386/kernel/apm.c with the corresponding apm.c
from 2.4.7 and got my apm functions to work again.

What has changed since 2.4.7?

DS


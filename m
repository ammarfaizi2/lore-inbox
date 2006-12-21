Return-Path: <linux-kernel-owner+w=401wt.eu-S1422806AbWLUIel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWLUIel (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWLUIel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:34:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:64661 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422806AbWLUIek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:34:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=to4uSIMJcqJGsVnKqbRK7ZnRl4pTsajxJ7ky+Uohpas4w8bSdTaJtty3ukmkM/qq1l1YgPuUyrJOps8o5U0Bdmc5sOfmg5Jv595P/aJmzwgEQQ5qMSH1gT6YbgnrNhA28uh2tifvEBmBYb1K+ODYDGRy9hjy9XIkWQdOloARENI=
Message-ID: <458A471C.3090402@gmail.com>
Date: Thu, 21 Dec 2006 09:34:36 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH -rt 0/4] ARM: OMAP: Add clocksource and clockevent driver
 for OMAP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Dirk Behme <dirk.behme@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patches for CONFIG PREEMPT RT add clocksource
and clockevent driver for ARM based TI OMAP devices.

They are against linux-2.6.19 + patch-2.6.20-rc1 +
patch-2.6.20-rc1-rt1. The clocksource patch went through
several review cycles on OMAP list.

Dirk

Btw: What's about

[PATCH -rt][RESEND] fix preempt hardirqs on OMAP
http://www.ussg.iu.edu/hypermail/linux/kernel/0612.1/0642.html

?

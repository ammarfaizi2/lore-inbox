Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVL2MyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVL2MyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVL2MyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:54:12 -0500
Received: from [202.67.154.148] ([202.67.154.148]:41656 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1750701AbVL2MyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:54:11 -0500
Message-ID: <43B3DC7A.7010000@ns666.com>
Date: Thu, 29 Dec 2005 13:54:18 +0100
From: Trilight <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14.5 / swapping / killing random apps
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya all,

I was wondering about the following;


kernel: 2.6.14.5 / vanilla

If a system with say a swap of 2GB on a fast drive and like 260MB is
actively used for swapping, could it cause certain applications to crash
? I noticed that the when swapping occurs, usualy above 200MB then
random apps start to crash. Sometimes gnome-terminal, gnome-panel,
xchat, metacity and so on. It happens a few times in usually 48 hours.

The system has 512MB ram, ECC , checked and cleared. The system can be
booted with m$ xp or freebsd but crashes do not occur even under heavy
load. So that's why i'm thinking something is causing this behaviour in
linux. I also have to say that dmcrypt was used for the swap but that
caused the crashes to increase, so dmcrypt is not used anymore just a
normal swap and crashes decreased to "rare" within 24 hours.

Or is it "normal" that the crash risk of running apps increases the more
swapping is done ?

I plan to upgrade the memory to 1.5GB anyway, but this issue is kinda
bothering me.

Thanks in advance for any input !

Mark

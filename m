Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRHaTlr>; Fri, 31 Aug 2001 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHaTli>; Fri, 31 Aug 2001 15:41:38 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:47880 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S268963AbRHaTlb>;
	Fri, 31 Aug 2001 15:41:31 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Fri, 31 Aug 2001 20:31:15 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Spurious VIA bug messages in 2.4.7-ac5
Message-ID: <Pine.LNX.4.21.0108312022550.711-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this has already been fixed, but I don't remember seeing it
mentioned before. I've just booted my test box after nearly 3 weeks
downtime, and I noticed the following message a couple of times in the
first 5 minutes. I assume it's harmless.

reg_kipling kernel: probable hardware bug: clock timer configuration lost
reg_kipling kernel: probable hardware bug: restoring chip configuration.

This is from the log, the screen display said something about a probable
VIA chipset. The only problem is that it doesn't use a VIA chipset. It's 
a Jetway 542C mobo with a K6/2 and an ALI chipset. I compiled it with 
gcc-3.0, so it might be a gcc/kernel interaction.

More data (config, whatever) available if required.

Ken
-- 
   Never drink more than two pangalacticgargleblasters !
Home page : http://www.kenmoffat.uklinux.net


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbRCXPB6>; Sat, 24 Mar 2001 10:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbRCXPBs>; Sat, 24 Mar 2001 10:01:48 -0500
Received: from dial087.za.nextra.sk ([195.168.64.87]:260 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S131691AbRCXPBm>;
	Sat, 24 Mar 2001 10:01:42 -0500
Date: Sat, 24 Mar 2001 16:27:06 +0100
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Cannot compile 2.4.2-ac23 kernel
Message-ID: <20010324162706.A10867@Boris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello anybody.

Today i applied A.COX's patch 2.4.2-ac23 on 2.4.0 kernel previsiously patched
with 2.4.1 and 2.4.2 patches.

Before everything used to compile well, but with this patch i get this
error message:

setup.c: In function `identify_cpu':
setup.c:2280: `tsc_disable' undeclared (first use in this function)
setup.c:2280: (Each undeclared identifier is reported only once
setup.c:2280: for each function it appears in.)

and compilation stops.

Did i do wrong, if i patched ac23 over clean 2.4.2, or should i have to patch
ac23 directly over 2.4.1 (2.4.0 ?). I tried both, but got lots of error
messages.

My current gcc:   2.95.3
           make:  3.79.1
           as:    2.10.90

CPU:       Intel P1 166 MMX

Can somebody help me, what did i do wrong ?

Thanks                                                                   B.

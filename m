Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbREMUu2>; Sun, 13 May 2001 16:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbREMUuS>; Sun, 13 May 2001 16:50:18 -0400
Received: from www.teaparty.net ([216.235.253.180]:30732 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S261322AbREMUuG>;
	Sun, 13 May 2001 16:50:06 -0400
Date: Sun, 13 May 2001 21:50:05 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.4-ac8 boot lockup
Message-ID: <Pine.LNX.4.10.10105132130410.17200-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi: Just tried to boot 2.4.4-ac8 on my thinkpad: I have an eepro100
ethernet card, which works fine under 2.4.3-ac14 and 2.4.4  - when I tried
2.4.4-ac8 things got as far as pump trying to bring up the eth0 interface,
and the machine locked up - this happened a few times [I have not enabled
CONFIG_EEPRO100_PM, and have set CONFIG_EEPRO100=m], so I did a make
mrproper and recompiled and reinstalled the 2.4.4-ac8 kernel, which
resulted in a panic and lockup even earlier in the boot sequence:
something about not being able to handle a device with more than 16 heads.

Not a problem for me or anything, but if anyome wants me to try stuff out
or investigate further, I'd be happy to.

-- 
"Aren't you ashamed of yourself?"
"No, I have people to do that for me."


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVCTCLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVCTCLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 21:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVCTCLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 21:11:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261988AbVCTCLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 21:11:42 -0500
Date: Sun, 20 Mar 2005 03:11:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: linux-msdos@vger.kernel.org
Subject: 2.6.12-rc1 breaks dosemu
Message-ID: <20050320021141.GA4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xdosemu 1.2.2 runs fine under 2.6.11.5, but fails under 2.6.12-rc1 with 
the following error:

<--  snip  -->

$ xdosemu 
ERROR: cpu exception in dosemu code outside of VM86()!
trapno: 0x0e  errorcode: 0x00000005  cr2: 0xffffff8e
eip: 0x000069ee  esp: 0xbfdbffcc  eflags: 0x00010246
cs: 0x0073  ds: 0x007b  es: 0x007b  ss: 0x007b
Page fault: read instruction to linear address: 0xffffff8e
CPU was in user mode
Exception was caused by insufficient privilege

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


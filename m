Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135789AbREDC0s>; Thu, 3 May 2001 22:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135818AbREDC0i>; Thu, 3 May 2001 22:26:38 -0400
Received: from live.wasp.net.au ([202.61.164.12]:49162 "HELO live.wasp.net.au")
	by vger.kernel.org with SMTP id <S135789AbREDC0d>;
	Thu, 3 May 2001 22:26:33 -0400
Date: Fri, 4 May 2001 10:26:29 +0800 (WST)
From: Matt Kemner <kemner@live.wasp.net.au>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: sparc: Run out of nocached RAM!
Message-ID: <Pine.LNX.4.30.0105041009550.3666-100000@live.wasp.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I run kernel 2.4.1 (from the Debian kernel-source-2.4.1-3 package) on an
Axil 320 (Dual Hypersparc) with 320MB of RAM, which just died (full
lockup) with the message "Run out of nocached RAM!" being the last message
on the screen. I located that printk in arch/sparc/mm/srmmu.c but I'm
afraid my kernel hacking skills are close to non-existant, so am hoping
for suggestions. (eg. "Don't run that kernel", "Please send more info",
"Go away or I will replace you with a very small shell script")

The machine is not under a great deal of load - it only runs the website
and mailing list for the local LUG, which previously ran OK on a Sparc
Classic with 32MB of RAM (albeit very s l o w l y) so I don't think it ran
out of memory.

I have posted the kernel config and dmesg output at
http://plug.linux.org.au/~kemner/

If you need anything else, please let me know

ADVthanksANCE

 - Matt Kemner
Perth Linux Users Group


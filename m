Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265229AbRFUVMp>; Thu, 21 Jun 2001 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbRFUVMf>; Thu, 21 Jun 2001 17:12:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3590 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265229AbRFUVMX>; Thu, 21 Jun 2001 17:12:23 -0400
Subject: Re: Linux 2.4.5-ac17
To: tmv5@home.com (Tom Vier)
Date: Thu, 21 Jun 2001 22:11:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010621155109.A15532@zero> from "Tom Vier" at Jun 21, 2001 03:51:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DBjr-0002Df-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> anyone working on a bootflag.c for alpha?
> 
> init/main.o: In function `init':
> main.c(.text+0x148): undefined reference to `linux_booted_ok'
> main.c(.text+0x14c): undefined reference to `linux_booted_ok'
> make: *** [vmlinux] Error 1

Just #define it to a null function. I don't believe ARC or SRM have the
same functionality

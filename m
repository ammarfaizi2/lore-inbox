Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVAIByn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVAIByn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVAIByn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:54:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11718 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262186AbVAIByl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:54:41 -0500
Subject: Re: [PATCH] small ftape cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
In-Reply-To: <200501082336.j08Na0ha003117@hera.kernel.org>
References: <200501082336.j08Na0ha003117@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105231821.12004.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 00:50:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changeset below was submitted with the wrong documentation. Any
chance of someone providing the right documentation to the actual large
change to ftape below (which does look sane but nothign to do with rio)


> ChangeSet 1.2406, 2005/01/08 14:19:45-08:00, bunk@stusta.de
> 
> 	[PATCH] small ftape cleanups
> 	
> 	The patch below does cleanups under drivers/char/rio/ including the
> 	following:
> 	
> 	- remove some completely unused code
> 	- make some needlessly global code static
> 	
> 	Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  compressor/zftape-compress.c |    4 --
>  lowlevel/fc-10.c             |    4 +-
>  lowlevel/fdc-io.c            |   67 ++++++-------------------------------------
>  lowlevel/fdc-io.h            |    5 ---
>  lowlevel/ftape-bsm.c         |    8 ++++-



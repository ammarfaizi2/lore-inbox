Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271668AbRHUNqq>; Tue, 21 Aug 2001 09:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271667AbRHUNqi>; Tue, 21 Aug 2001 09:46:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14609 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271668AbRHUNqV>; Tue, 21 Aug 2001 09:46:21 -0400
Subject: Re: 2.4.8-ac8, agpgart, r128, and mtrr
To: dushaw@apl.washington.edu (Brian Dushaw)
Date: Tue, 21 Aug 2001 14:48:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108210423110.3231-100000@munk.apl.washington.edu> from "Brian Dushaw" at Aug 21, 2001 05:01:53 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZBtf-0007pD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The module r128.o needs to have agpgart loaded first and depmod
> does not seem to set this up properly.  I've added the line:

Its not a dependancy it can deduce. Imagine your card was PCI

> "pre-install r128 modprobe agpgart " to my /etc/modules.conf file.

Correct.

> when loaded in, lsmod shows it as being unused, if r128 is not
> loaded.  I have the XFree86 glx module loaded, I think.  I think I don't
> understand this at all... without the dri modules agpgart seems
> innocuous...so why bother?

AGP for most cards is currently used for 3D acceleration only

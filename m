Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287203AbSACMZb>; Thu, 3 Jan 2002 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287199AbSACMZV>; Thu, 3 Jan 2002 07:25:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65284 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287202AbSACMZL>; Thu, 3 Jan 2002 07:25:11 -0500
Subject: Re: ISA slot detection on PCI systems?
To: cs@zip.com.au
Date: Thu, 3 Jan 2002 12:35:36 +0000 (GMT)
Cc: Lionel.Bouton@free.fr (Lionel Bouton),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones)
In-Reply-To: <20020103144904.A644@zapff.research.canon.com.au> from "Cameron Simpson" at Jan 03, 2002 02:49:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M75s-0008Bz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	  binary may have bugs, security holes, race conditions etc; it may be
> 	  hacked post boot (no so easy to do to the live kernel image), etc

Just like the kernel, only the binary is a little less dangerous. Hacking
live kernel images is trivial also btw. There are tools for it.

> Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
> with the kernel; in-kernel code is fundamentally in sync.

Disagree. Its reading BIOS tables not poking at kernel internals

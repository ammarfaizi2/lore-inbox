Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTH0Bd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTH0Bd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:33:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6509 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263043AbTH0BdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:33:25 -0400
Date: Tue, 26 Aug 2003 21:33:24 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small sparc Makefile cleanups
Message-ID: <20030826213324.B16588@devserv.devel.redhat.com>
References: <20030826221922.GJ7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030826221922.GJ7038@fs.tum.de>; from bunk@fs.tum.de on Wed, Aug 27, 2003 at 12:19:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#
> -# Uncomment the first CFLAGS if you are doing kgdb source level
> -# debugging of the kernel to get the proper debugging information.
> -
> -IS_EGCS := $(shell if $(CC) -m32 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo y; else echo n; fi; )
> -NEW_GAS := $(shell if $(LD) --version 2>&1 | grep 'elf64_sparc' > /dev/null; then echo y; else echo n; fi)

Actually, let me rephrase the question. Does anyone still use
UltraPenguin 1.x or Red Hat 5.x userland for kernel hacking?
If I get no reply in a week, this goes in.

-- Pete

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbTH0Bbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTH0Bbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:31:44 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:35688 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263031AbTH0Bbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:31:42 -0400
Date: Tue, 26 Aug 2003 21:30:40 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small sparc Makefile cleanups
Message-ID: <20030826213040.A16588@devserv.devel.redhat.com>
References: <20030826221922.GJ7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030826221922.GJ7038@fs.tum.de>; from bunk@fs.tum.de on Wed, Aug 27, 2003 at 12:19:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: 	Wed, 27 Aug 2003 00:19:23 +0200
> From: Adrian Bunk <bunk@fs.tum.de>

> -#
> -# Uncomment the first CFLAGS if you are doing kgdb source level
> -# debugging of the kernel to get the proper debugging information.
> -
> -IS_EGCS := $(shell if $(CC) -m32 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo y; else echo n; fi; )
> -NEW_GAS := $(shell if $(LD) --version 2>&1 | grep 'elf64_sparc' > /dev/null; then echo y; else echo n; fi)

This is sane, and was on todo list of months. Just shows
what kind of backlog I accumulated. Can someone else test it
for me? Please reply with result and outut from
 gcc -v && as -v < /dev/null.

-- Pete

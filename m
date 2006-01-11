Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWAKUEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWAKUEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWAKUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:04:08 -0500
Received: from smtpout04-03.prod.mesa1.secureserver.net ([64.202.165.198]:30156
	"HELO smtpout04-03.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S932407AbWAKUEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:04:07 -0500
Date: Wed, 11 Jan 2006 13:03:42 -0700
From: akennedy@techmoninc.com
Subject: ixp4xx_defconfig
To: linux-kernel@vger.kernel.org
Message-ID: <20060111130342.bfc52cea95091b0fffcb409eab6296ba.5d36bccaec.wbe@email.secureserver.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
X-Originating-IP: 24.177.178.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me :shameful: as I'm not part of the list.

Please forgive if this has already been asked (I did look and couldn't
find the answer).

I have a fresh install of 2.6.15, patched with 2.6.15-git6, edited the
top-level make file and changed the ARCH ?= <blah> to ARCH = arm

I then issue the following commands
make ixp4xx_defconfig
make

and I get the following:
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-ixp4xx
  Generating include/asm-arm/mach-types.h
  SYMLINK include/asm -> include/asm-arm
  CC      arch/arm/kernel/asm-offsets.s
cc1: error: invalid option `big-endian'
cc1: error: invalid option `apcs'
cc1: error: invalid option `no-sched-prolog'
cc1: error: invalid option `abi=apcs-gnu'
cc1: error: invalid option `tune=strongarm110'
cc1: error: bad value (armv4) for -march= switch
cc1: error: bad value (armv4) for -mcpu= switch
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

I'm sure that I'm not doing something easy, but I'm a virgin to Embedded
systems.

Sorry for the post, I know you guys have more to do than answer
questions
for embedded newbies.

Thanks in advance for any assistance you can offer.

Andy Kennedy
Sr. Programmer
Technical Monitoring Research Inc.


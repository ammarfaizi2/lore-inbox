Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUEPRBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUEPRBx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUEPRBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:01:53 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:3522 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S263685AbUEPRBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:01:52 -0400
From: Jan Killius <jkillius@arcor.de>
Reply-To: jkillius@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
Date: Sun, 16 May 2004 19:01:46 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161901.46375.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
there is a problem if CONFIG_HPET_EMULATE_RTC is enabled on a x86-64 system.
Here is the error:
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.text+0x87e9): In function `hpet_rtc_interrupt':
: undefined reference to `rtc_interrupt'

-- 
        Jan

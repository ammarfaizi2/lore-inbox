Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUHDHSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUHDHSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 03:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUHDHSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 03:18:50 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:34312 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S267314AbUHDHSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 03:18:47 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8rc3] build failed.
Date: Wed, 4 Aug 2004 09:18:42 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040918.42311.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# make bzImage

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux

ld:arch/i386/kernel/vmlinux.lds.s:1:
   ignoring invalid character `#' in expression
ld:arch/i386/kernel/vmlinux.lds.s:1:
   syntax error
make: *** [vmlinux] Error 1


# head -n 10 vmlinux.lds.s

# 1 "arch/i386/kernel/vmlinux.lds.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "arch/i386/kernel/vmlinux.lds.S"
(...)
# 1 "include/asm-generic/vmlinux.lds.h" 1
(...)

binutils-2.15.91.0.2-1
gcc-3.4.2-0.20040730.1

Any ideas?

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

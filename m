Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbUDSLHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUDSLHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:07:49 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:12983 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S264349AbUDSLHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:07:47 -0400
From: Jan Killius <jkillius@arcor.de>
Reply-To: jkillius@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc1-mm1 x86-64 assembler problem
Date: Mon, 19 Apr 2004 13:08:58 +0200
User-Agent: KMail/1.6.51
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191308.58989.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
There is a problem with some x86-64 assembler code.
  CHK     include/linux/compile.h
  LD      arch/x86_64/kernel/bootflag.o
  AS      arch/x86_64/kernel/warmreboot.o
arch/x86_64/kernel/warmreboot.S: Assembler messages:
arch/x86_64/kernel/warmreboot.S:67: Warning: rest of line ignored; first 
ignored character is `w'
arch/x86_64/kernel/warmreboot.S:71: Warning: rest of line ignored; first 
ignored character is `w'
arch/x86_64/kernel/warmreboot.S:67: Error: can't resolve `.text' {.text 
section} - `' {*UND* section}
arch/x86_64/kernel/warmreboot.S:71: Error: can't resolve `.text' {.text 
section} - `' {*UND* section}

gcc version: gcc version 3.3.3 (Gentoo Linux 3.3.3_pre20040408-r1)
as version: GNU assembler version 2.14.90.0.8 (x86_64-pc-linux-gnu) using BFD 
version 2.14.90.0.8 20040114
-- 
        Jan

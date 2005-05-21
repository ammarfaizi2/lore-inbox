Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVEUO0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVEUO0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 10:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVEUO0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 10:26:03 -0400
Received: from smtp07.web.de ([217.72.192.225]:46038 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S261579AbVEUOZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 10:25:59 -0400
From: Gregor Jasny <gjasny@web.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: What happened to Cyrix 6x86 support in 2.6?
Date: Sat, 21 May 2005 16:25:56 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505211625.56664.gjasny@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old machine with a Cyrix 6x86 processor. When running Linux 2.4 it is recognized as a Cyrix and MTRR is enabled:

kernel: Linux version 2.4.22 (root@Rincewind) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Fri Nov 28 15:43:13 CET 2003
...
kernel: Enabling CPUID on Cyrix processor.
kernel: CPU:     After generic, caps: 00000105 00000000 00000000 00000004
kernel: CPU:             Common caps: 00000105 00000000 00000000 00000004
kernel: CPU: Cyrix 6x86L 2x Core/Bus Clock stepping 02

But when I boot a Linux 2.6 kernel with CONFIG_M586=y it recognizes only a 486.

Can somebody explain this behavior? Was support for Cyrix 6x86 dropped?

Cheers,
Gregor

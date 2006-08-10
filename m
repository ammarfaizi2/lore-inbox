Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWHJGxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWHJGxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWHJGxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:53:10 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:4000 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161050AbWHJGxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:53:09 -0400
Date: Thu, 10 Aug 2006 08:52:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sam@ravnborg.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kbuild visuals
Message-ID: <Pine.LNX.4.61.0608100850050.10926@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


just caught this little indentation issue on Kconfig output whilst 
compiling 2.6.18-rc4 on x64:

[...]
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP System.map
  SYSMAP .tmp_System.map
  AS      arch/x86_64/boot/bootsect.o
  LD      arch/x86_64/boot/bootsect
[...]



Jan Engelhardt
-- 

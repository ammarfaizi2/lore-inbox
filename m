Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFNVtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTFNVtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:49:55 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:38157 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261168AbTFNVty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:49:54 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306142203.SAA24912@clem.clem-digital.net>
Subject: 2.5.71 fails compile (net/built-in.o)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 14 Jun 2003 18:03:43 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:


  CPP     arch/i386/vmlinux.lds.s
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o: In function `flow_cache_init':
net/built-in.o(.init.text+0x282): undefined reference to `register_cpu_notifier'
make: *** [.tmp_vmlinux1] Error 1

-- 
Pete Clements 
clem@clem.clem-digital.net

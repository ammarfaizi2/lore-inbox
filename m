Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUHCSza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUHCSza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUHCSza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:55:30 -0400
Received: from [138.15.108.3] ([138.15.108.3]:62441 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S266798AbUHCSz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:55:29 -0400
Subject: modversion.h in kernel 2.6.x
From: Lei Yang <leiyang@nec-labs.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain
Message-Id: <1091570120.5487.82.camel@bijar.nec-labs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 14:55:20 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2004 18:55:19.0029 (UTC) FILETIME=[6BDD3250:01C4798B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could anyone tell me what happened with modversion.h in 2.6.x? I want to
build a module whose makefile indicates that,

ifdef CONFIG_MODVERSIONS
MODVERSIONS:= -DMODVERSIONS -include
$(KERNEL_DIR)/include/linux/modversions.h
CKERNOPS += $(MODVERSIONS)
endif

I checked .config in source tree and yes, CONFIG_MODVERSIONS is defined
as 'y'. But there is just no modversions.h in /include/linux :( Also, I
don't think it is in kernel version 2.4.x.

What the hack is modversions.h? 

Thanks!

Lei


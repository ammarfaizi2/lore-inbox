Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUKJQO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUKJQO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUKJQOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:14:25 -0500
Received: from [213.80.72.10] ([213.80.72.10]:6472 "EHLO kubrik.opensource.se")
	by vger.kernel.org with ESMTP id S261989AbUKJQNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:13:20 -0500
Subject: patch-2.6.10-rc1.bz2 contents nitpicking
From: Magnus Damm <damm@opensource.se>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1100103329.8660.128.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 17:15:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Applying the patch "patch-2.6.10-rc1.bz2" results in one empty file,
"arch/arm/mach-iop3xx/arch.c". This is probably because the "+++"-line
in the patch sets the file name to something else than "/dev/null". 

This itself is not a problem, just use "patch -E" to apply it.

My concern is that other files in the patch are using "/dev/null" like
"arch/ia64/sn/io/Makefile" so they are removed correctly.

Why the mix of empty and removed files?

Thanks!

/ magnus


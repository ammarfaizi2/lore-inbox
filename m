Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVBZVuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVBZVuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBZVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 16:50:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61355 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261249AbVBZVuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 16:50:37 -0500
Date: Sat, 26 Feb 2005 22:50:36 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200502262150.j1QLoaH25198@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: cyrix_arr_init and centaur_mcr_init unused?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/cpu/mtrr/cyrix.c has a routine cyrix_arr_init(), and
arch/i386/kernel/cpu/mtrr/centaur.c has a routine centaur_mcr_init().
At first sight it looks like these are unused.
Do I overlook something?

(They occur as the .init fields of some struct, and I did not find any
calls of ->init().)

If there are no calls and the code is needed, then some systems
may be broken today. If the code is not needed, maybe it should
be removed.

Andries

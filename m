Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUL1SXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUL1SXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUL1SXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:23:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1174 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261204AbUL1SXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:23:06 -0500
Date: Tue, 28 Dec 2004 19:23:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John Way <wayjd@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Sym-2
In-Reply-To: <20041228172554.38787.qmail@web60307.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0412281921270.3365@yvahk01.tjqt.qr>
References: <20041228172554.38787.qmail@web60307.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>2. I'm having a problem with the new SYM-2 drivers
>when using the newly released 2.6.10 kernel. I've
>tried compiling it into the kernel, and again as
>modules, but still the 'mkinitrd" says "No module

Sounds like you need to `make modules_install` first. Or drop the initrd in 
one (i.e. compile it in and do not worry about any initrd)

>sym53c8xx found for kernel 2.6.10, aborting." My scsi
>drives are NOT my boot drives, they're just extra
>storage. Everything worked perfectly with the
>2.6.10-rc2 patched kernel and below.
>
>3. initrd, modules, kernel, compiling

If that is the order, it's wrong.
menuconfig -> select sym -> compile it -> (install) -> mkinitrd


Jan Engelhardt
-- 
ENOSPC

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265351AbUGDCrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUGDCrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 22:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUGDCrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 22:47:49 -0400
Received: from zero.aec.at ([193.170.194.10]:62472 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265351AbUGDCrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 22:47:48 -0400
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Weird:  30 sec delay during early boot
References: <2e55c-392-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 04 Jul 2004 04:47:43 +0200
In-Reply-To: <2e55c-392-7@gated-at.bofh.it> (Jeff Garzik's message of "Sun,
 04 Jul 2004 04:40:06 +0200")
Message-ID: <m3hdsoebe8.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> This appeared in -bk-latest in the past day or two.
>
> BK-current on x86-64 (config/dmesg/lspci attached) will pause for 30
> wall-clock seconds immediately after being loaded by the bootloader,
> then will proceed to boot successfully and function correctly.  This
> is reproducible on every boot.
>
> So, 30 seconds with no printk output, then boots normally.

Boot with earlyprintk=serial,ttySx,baud or earlyprintk=vga
That should enable printk from the beginning and may give
some clues.

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265353AbUGDCxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUGDCxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 22:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUGDCxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 22:53:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44709 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265353AbUGDCxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 22:53:11 -0400
Message-ID: <40E7710A.4020601@pobox.com>
Date: Sat, 03 Jul 2004 22:52:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird:  30 sec delay during early boot
References: <2e55c-392-7@gated-at.bofh.it> <m3hdsoebe8.fsf@averell.firstfloor.org>
In-Reply-To: <m3hdsoebe8.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>This appeared in -bk-latest in the past day or two.
>>
>>BK-current on x86-64 (config/dmesg/lspci attached) will pause for 30
>>wall-clock seconds immediately after being loaded by the bootloader,
>>then will proceed to boot successfully and function correctly.  This
>>is reproducible on every boot.
>>
>>So, 30 seconds with no printk output, then boots normally.
> 
> 
> Boot with earlyprintk=serial,ttySx,baud or earlyprintk=vga
> That should enable printk from the beginning and may give
> some clues.

would early printk show something that dmesg(8) would not?

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTK3R2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTK3R2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:28:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264968AbTK3RZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:25:04 -0500
Message-ID: <3FCA27E0.5040809@pobox.com>
Date: Sun, 30 Nov 2003 12:24:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Pavel Machek <pavel@ucw.cz>,
       "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: FYI: My current suspend bigdiff
References: <3FC7860C.2060505@gmx.de> <20031128173312.GH303@elf.ucw.cz> <3FC789F5.2000208@gmx.de> <20031128175503.GB18072@elf.ucw.cz> <3FC7908A.9030007@gmx.de> <20031128235623.GB18147@elf.ucw.cz> <3FC8C0DB.9050107@gmx.de> <20031129172537.GB459@elf.ucw.cz> <3FC9C560.2070902@gmx.de> <20031130171833.GB516@elf.ucw.cz> <20031130172134.GB10679@suse.de>
In-Reply-To: <20031130172134.GB10679@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Curious - can't this be put some place a bit smarter, so we don't have
> to update every single "driver" with a kernel thread out there (like in
> the scheduler)? Seems pretty fragile to rely on this. Plus, when you
> change this in the future there'll be N drivers to update again.


Agreed.  I had to do this simple and obvious (and template-able) patch 
for 8139too and another driver whose name I forget ATM...

	Jeff




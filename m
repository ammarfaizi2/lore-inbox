Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVEPOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVEPOdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVEPOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:33:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54939 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261663AbVEPOdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:33:36 -0400
Message-ID: <4288AF3A.2000008@pobox.com>
Date: Mon, 16 May 2005 10:33:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl> <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz> <20050516111859.GB13387@merlin.emma.line.org>
In-Reply-To: <20050516111859.GB13387@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Sun, 15 May 2005, Mikulas Patocka wrote:
> 
> 
>>Note that disk can still ignore FLUSH CACHE command cached data are small
>>enough to be written on power loss, so small FLUSH CACHE time doesn't
>>prove disk cheating.
> 
> 
> Have you seen a drive yet that writes back blocks after power loss?
> 
> I have heard rumors about this, but all OEM manuals I looked at for
> drives I bought or recommended simply stated that the block currently
> being written at power loss can become damaged (with write cache off),
> and that the drive can lose the full write cache at power loss (with
> write cache on) so this looks like daydreaming manifested as rumor.

Upon power loss, at least one ATA vendor's disks try to write out as 
much data as possible.

	Jeff




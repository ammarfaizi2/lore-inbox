Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUALVUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266483AbUALVUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:20:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29341 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266326AbUALVTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:19:33 -0500
Message-ID: <40030F52.4070000@pobox.com>
Date: Mon, 12 Jan 2004 16:19:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aron Rubin <arubin@atl.lmco.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.1]  Silicon Image 3512 SATA Controller - Tested
References: <4002B314.2010502@atl.lmco.com>
In-Reply-To: <4002B314.2010502@atl.lmco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aron Rubin wrote:
> This patch enables the Silicon Image 3512 SATA Controller and has been 
> tested and functioning without any apparent bugs (I do not have a full 
> test suite but I am not booting off a device attached to this 
> controller). This patch is against the Dave Jones 2.6.1-1.34 kernel 
> source rpm.
> 
> You may remember I was trying to get help on this chipset before. My 
> patch is simply a duplicate of the entries for the 3112 chipset. It did 
> not work fully with prior kernels, giving me a "Interrupt Lost" errors. 
> Whatever else was done to 2.6.1 had made it happy again. Also I did not 
> have to use any special commandline options.


Did you test the sata_sil driver as well?

It's patch should just be one line...  No need to add a duplicate 
ata_host_info entry when you could instead just reference the sil_3112 
settings...

Thanks,

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbULPSDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbULPSDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbULPSDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:03:15 -0500
Received: from neopsis.com ([213.239.204.14]:29923 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261961AbULPSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:03:10 -0500
Message-ID: <41C1CE60.5010606@dbservice.com>
Date: Thu, 16 Dec 2004 19:05:20 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Conway <nconway_kernel@yahoo.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3TB disk hassles
References: <20041216173811.7697.qmail@web26505.mail.ukl.yahoo.com>
In-Reply-To: <20041216173811.7697.qmail@web26505.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Conway wrote:
> Hi Tom...
> 
>  --- Tomas Carnecky <tom@dbservice.com> wrote: 
> 
>>I had a GUID partition table (GPT) on my system (x86, normal 
>>mainboard/BIOS etc) and it worked fine. I didn't need a separate boot
>>disk. I used grub as the boot loader. I think if you enable GPT in
>>the 
>>kernel you should be able to boot stright from the big disk.
> 
> 
> Wow, that's unexpected but encouraging news.  What distro?  Did it
> allow you to go GPT right from the off, or did you have to migrate from
> an MSDOS ptbl to a GPT one after installation?
> 

It was gentoo, and I even think I installed it right onto the GPT disk, 
so no migration. But I'm not sure. You just have to look that your 
kernel supports GPT. I don't know if the kernel from the gentoo livecd 
supports GPT.

Also have a look here how to create GPT partitions:
http://www.google.ch/search?q=site%3Ausefulthings.org.uk+gpt
I think I did it like it's shown there, mklabel, mkpart and mount them.
I don't think I migrated from MSDOS to GPT, because I don't even know 
how it'is possible if you have only one disk with the system on it.

While looking for gentoo GPT support, I found this:
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/0624.html
Looks like CONFIG_EFI_PARTITION is enabled by default now on the newer 
kernels.

tom

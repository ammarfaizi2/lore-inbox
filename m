Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUFRV5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUFRV5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUFRV4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:56:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264641AbUFRVxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:53:06 -0400
Message-ID: <40D3642E.4050509@pobox.com>
Date: Fri, 18 Jun 2004 17:52:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hannu Savolainen <hannu@opensound.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
       4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local> <40D2464D.2060202@opensound.com> <Pine.LNX.4.58.0406181205500.13079@scrub.local> <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Savolainen wrote:
> On Fri, 18 Jun 2004, Roman Zippel wrote:
> 
> 
>>To quote from your previous mail:
>>
>>
>>>make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
>>
>>That doesn't really like documented interfaces to me.
> 
> Right. The documented command is "make install". However an undocumented

Really?

I always do

	make modules_install
	installkernel <kversion> arch/i386/boot/bzImage System.map

The arch-independent installkernel script should perform the necessary 
actions to install the kernel image in a bootable area.


> The actual problem is that there is no standardized way to compile modules
> outside the kernel source tree. There will be serious problems if
> different distributions need slightly different installation procedure.
> Who is going to be able to tell the customer what exactly he should do?

In 2.6.x there is a way to do this :)

Sam Ravnborg recently posted documentation for this, as well.

	Jeff




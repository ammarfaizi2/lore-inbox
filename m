Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUFFVzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUFFVzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUFFVzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:55:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65484 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264165AbUFFVzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:55:22 -0400
Message-ID: <40C392BB.3020406@pobox.com>
Date: Sun, 06 Jun 2004 17:55:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@fsmlabs.com>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Disable scheduler debugging
References: <20040606033238.4e7d72fc.ak@suse.de> <20040606055336.GA15350@elte.hu> <40C3452B.5010500@pobox.com> <Pine.LNX.4.58.0406061742100.1838@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0406061742100.1838@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 6 Jun 2004, Jeff Garzik wrote:
> 
> 
>>Unfortunately there are just, flat-out, way too many kernel messages at
>>boot-up.  Making them KERN_DEBUG doesn't solve the fact that SMP boxes
>>often overflow the printk buffer before you boot up to a useful userland
>>that can record the dmesg.
>>
>>The IO-APIC code is a _major_ offender in this area, but the CPU code is
>>right up there as well.
> 
> 
> How about the configurable log buffer size patch? I think Andrew still has
> that amongst his wares.

It's in mainline.  That's no excuse for the voluminous logs, though... 
I'm a "1-2 lines per module" type of person :)

	Jeff




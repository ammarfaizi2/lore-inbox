Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWGNLvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWGNLvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWGNLvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:51:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:39598 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161092AbWGNLvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:51:31 -0400
Message-ID: <44B78538.6030909@garzik.org>
Date: Fri, 14 Jul 2006 07:51:20 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: greg@kroah.com, akpm@osdl.org, cw@f00f.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
In-Reply-To: <44B78294.1070308@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Jeff Garzik wrote:
>> Daniel Drake wrote:
>>> Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 
>>> regression:
>>> new kernels will not boot their system from their VIA SATA hardware.
>>>
>>> The solution is just to add the SATA device to the fixup list.
>>> This should also fix the same problem reported by Scott J. Harmon on 
>>> LKML.
>>>
>>> Signed-off-by: Daniel Drake <dsd@gentoo.org>
>>
>> Same NAK comment as before...
> 
> I didn't see this patch posted anywhere before, but I just did some more 
> searching and found something similar. Are you referring to 
> http://lkml.org/lkml/2006/6/24/184 ?

Same rationale, but the VIA SATA PCI ID had been submitted before, as 
well...

	Jeff




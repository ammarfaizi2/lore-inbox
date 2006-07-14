Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWGNLeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWGNLeB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWGNLeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:34:01 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:49909 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932498AbWGNLeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:34:00 -0400
Message-ID: <44B78294.1070308@gentoo.org>
Date: Fri, 14 Jul 2006 12:40:04 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: greg@kroah.com, akpm@osdl.org, cw@f00f.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org>
In-Reply-To: <44B77B1A.6060502@garzik.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Daniel Drake wrote:
>> Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 
>> regression:
>> new kernels will not boot their system from their VIA SATA hardware.
>>
>> The solution is just to add the SATA device to the fixup list.
>> This should also fix the same problem reported by Scott J. Harmon on 
>> LKML.
>>
>> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> Same NAK comment as before...

I didn't see this patch posted anywhere before, but I just did some more 
searching and found something similar. Are you referring to 
http://lkml.org/lkml/2006/6/24/184 ?

Daniel

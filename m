Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVIFW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVIFW7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIFW7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:59:37 -0400
Received: from outgoing-mail.its.caltech.edu ([131.215.239.19]:47606 "EHLO
	outgoing-mail.its.caltech.edu") by vger.kernel.org with ESMTP
	id S1751101AbVIFW7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:59:36 -0400
Message-ID: <431E1F4E.4080700@caltech.edu>
Date: Wed, 07 Sep 2005 01:59:26 +0300
From: Rumen Zarev <rzarev@caltech.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Unhide SMBus on Compaq Evo N620c
References: <200509062039.j86KdWMr014934@inky.its.caltech.edu> <1126046590.13159.9.camel@mindpipe>
In-Reply-To: <1126046590.13159.9.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-09-06 at 13:39 -0700, Rumen Ivanov Zarev wrote:
> 
>>Trivial patch against 2.6.13 to unhide SMBus on Compaq Evo N620c laptop using
>>Intel 82855PM chipset.
> 
> 
>>+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ)) {
> 
> 
> Should unlikely() be used for cases where the conditional will be true
> iff a specific piece of hardware is present?  Seems like we'd always
> lose.
> 
> Lee
> 
> 
> 

I just copied some code that was already there and modified it for my 
case. I don't really know HOW it works - I'm not much of a programmer 
myself.

Rumen


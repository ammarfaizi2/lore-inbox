Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVFGWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVFGWbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVFGWbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:31:45 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41679 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262017AbVFGWbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:31:33 -0400
Message-ID: <42A62040.2080808@pobox.com>
Date: Tue, 07 Jun 2005 18:31:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
CC: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: stupid SATA questions
References: <0EF82802ABAA22479BC1CE8E2F60E8C3216B53@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C3216B53@scl-exch2k3.phoenix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
>  
> 
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Garzik
>>Sent: Tuesday, June 07, 2005 11:01 AM
>>To: Kumar Gala
>>Cc: Linux Kernel list
>>Subject: Re: stupid SATA questions
>>
>>Kumar Gala wrote:
>>
>>>These questions were posed to me and I was hoping someone would have 
>>>better knowledge about the works and usage of SATA then I 
>>
>>do.  All of 
>>
>>>these questions are around understanding how important the 
>>
>>performance 
>>
>>>of PIO mode is.
>>>
>>>How often would one run in PIO mode?  Why would one run in PIO mode?
>>
>>Never.  No idea.  :)
> 
> 
> Some BIOSes/option ROMs do. Especially SATA RAID ones.
> But unless you are using BIOS interrupts... 

It doesn't matter what BIOS does, Linux SATA drivers don't use the BIOS.

	Jeff




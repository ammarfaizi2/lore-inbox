Return-Path: <linux-kernel-owner+w=401wt.eu-S1751313AbWLNRtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWLNRtM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWLNRtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:49:11 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:44666 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbWLNRtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:49:09 -0500
Message-ID: <458189FD.2080805@wolfmountaingroup.com>
Date: Thu, 14 Dec 2006 10:29:33 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Bob <spam@homeurl.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Need to enable caches in SMP ? (was Kernel 2.6 SMP very slow
 with ServerWorks LE Chipset)
References: <4577AA11.6020906@homeurl.co.uk>	<4580C054.2080902@homeurl.co.uk> <20061214110324.780b4bf0@localhost.localdomain>
In-Reply-To: <20061214110324.780b4bf0@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>>As per Alan's suggestion I decompressed the kernel source tree with the 
>>processes pegged to one CPU then the other, and as he predicted it took 
>>vastly longer on one CPU than the other, but I don't know what that 
>>implies, or how to fix it.
>>    
>>
>
>>From the timing it sounds like one processor cache is disabled which is a
>little peculiar to say the least.
>
>Alan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
enable the L1 cache in the processor. BIOS settings, no doubt.

Jeff

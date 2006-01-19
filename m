Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWASR0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWASR0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWASR0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:26:39 -0500
Received: from host233.omnispring.com ([69.44.168.233]:33734 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1030236AbWASR0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:26:38 -0500
Message-ID: <43CFCBB2.3050003@cfl.rr.com>
Date: Thu, 19 Jan 2006 12:26:10 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: govind raj <agovinda04@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RAID 5+0 support
References: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl>
In-Reply-To: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2006 17:27:23.0053 (UTC) FILETIME=[9BB9A5D0:01C61D1D]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14215.000
X-TM-AS-Result: No--7.990000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why on earth would you want to stripe two raid-5's instead of using one 
raid-5 that is twice as big?  You'd get more usable disk space that way. 


govind raj wrote:
> Hi all,
>
> We are using EVMS 2.5.4 on Linux 2.6.12.6 kernel version.
>
> We find that kernel modules are available for RAID0, 1, 5, 1+0 as part 
> of this kernel. But however, we do not find a similar module available 
> for RAID 5+0. Can someone advise us of how we would be able to get 
> this support added into the kernel? If this is not required as a 
> kernel module, how do we create a RAID 5+0 using MD?
>
> Thanks in advance for your help,
>
> Govind
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


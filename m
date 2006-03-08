Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWCHIMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWCHIMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWCHIMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:12:21 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56795 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932454AbWCHIMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:12:20 -0500
Message-ID: <440E9182.4010301@soft.fujitsu.com>
Date: Wed, 08 Mar 2006 17:10:42 +0900
From: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH][BUG] fix bug in ACPI based CPU hotplug
References: <440E8723.7030008@soft.fujitsu.com> <20060307233507.6ad0858f.akpm@osdl.org>
In-Reply-To: <20060307233507.6ad0858f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com> wrote:
> 
>>This patch fixes a serious bug in ACPI based CPU hotplug code. Because
>> of this bug, ACPI based CPU hotplug will always fail if NR_CPUS is
>> equal to or more than 255.
> 
> 
> Looks rather similar to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/broken-out/acpi-signedness-fix-2.patch
> ;)
> 
> I think they're functionally equivalent - the only difference is the ==-1
> versus <0 comparisons.
> 
> 

Oh, I didn't noticed it.
Sorry for the noise.

Thanks,
Kenji Kaneshige



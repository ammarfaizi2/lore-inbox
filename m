Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVIIVqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVIIVqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVIIVqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:46:08 -0400
Received: from gathered-geeks.org ([217.160.210.51]:37081 "EHLO
	p15132835.pureserver.info") by vger.kernel.org with ESMTP
	id S1030331AbVIIVqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:46:06 -0400
Message-ID: <4322029C.2010904@funzi.de>
Date: Fri, 09 Sep 2005 23:46:04 +0200
From: Christopher Beppler <psiml@funzi.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] hotplugging cpus via /sys/devices/system/cpu/
References: <4321F396.3010707@funzi.de> <20050909135556.A29542@unix-os.sc.intel.com>
In-Reply-To: <20050909135556.A29542@unix-os.sc.intel.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Fri, Sep 09, 2005 at 01:41:58PM -0700, Christopher Beppler wrote:
> 
>>   [1.] One line summary of the problem:
>>   If I deactivate a CPU with /sys/devices/system/cpux and try to
>>   reactivate it, then the CPU doesn't start and the kernel prints out an
>>   oops.
>>
> 
> 
> Could you try this on 2.6.13-mm2? If this is due to a sending broadcast
> IPI related issue that should fix the problem.

No... the oops occurs furthermore...

> I should say i didnt try i386 in a while
> but i suspect some of the recent suspend/resume code required some
> modifications to the i386 hotplug code which might be getting in the way
> if you just try logical cpu hotplug alone without using it for suspend/resume.
> 
> Shaohua might know more about the status.
> 
> Cheers,
> ashok
> 
> 


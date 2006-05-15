Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWEOM4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWEOM4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWEOM4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:56:41 -0400
Received: from math.ut.ee ([193.40.36.2]:36772 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751464AbWEOM4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:56:40 -0400
Date: Mon, 15 May 2006 15:56:31 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: nfsservctl() compatibility broken on AMD64?
In-Reply-To: <20060515042324.50af55c5.akpm@osdl.org>
Message-ID: <Pine.SOC.4.61.0605151555490.27015@math.ut.ee>
References: <Pine.SOC.4.61.0605151220130.27015@math.ut.ee>
 <20060515042324.50af55c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm trying to use the latest amd64 kernel (2.6.17-rc3 compiled last
>> week) with Debian Sarge 32-bit userland (is it reasonable to expect it
>> to work?).
>>
>> There's a problem with exportfs. I can export to IP ranges OK but I can
>> not export to single hosts - nfsservctl() returns EFAULT.
>
> Does this fix?

Yes, thanks! With this patch my workarounds are not needed.

-- 
Meelis Roos (mroos@linux.ee)

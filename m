Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVDNOBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVDNOBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 10:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDNOBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 10:01:12 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:9227 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261507AbVDNOBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 10:01:11 -0400
Message-ID: <425E78A4.6090409@aitel.hist.no>
Date: Thu, 14 Apr 2005 16:05:24 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomko <tomko@haha.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before
 using it
References: <425C9E55.6010607@haha.com> <20050413102916.GS4965@lug-owl.de>	<425CF7DB.4000407@haha.com> <tnxd5szvsnd.fsf@arm.com> <425DD105.7010304@haha.com>
In-Reply-To: <425DD105.7010304@haha.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomko wrote:

> Catalin Marinas wrote:
>
>>
>> No, it is because this function checks whether the access to the user
>> space address is OK. There are situations when it can also sleep (page
>> not present).
>>
>>  
>>
> what u means "OK"?  kernel space should have right to access any 
> memory address , can u expained in details what u means "OK"? 

The user may not have any right to that memory, that means he
has no right to ask the kernel to mess with it either, even if the
kernel is authorized to do so.

Just as you can't ask a cop to jail someone.  Sure, the cop has the power
to arrest, but he will check that there is reason to do so and not
automatically assume that you are right.

Helge Hafting

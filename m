Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWHaSbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWHaSbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHaSbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:31:52 -0400
Received: from smtpout.mac.com ([17.250.248.171]:12748 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932434AbWHaSbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:31:51 -0400
In-Reply-To: <1157045360.4366.4.camel@josh-work.beaverton.ibm.com>
References: <20060831100756.866727476@localhost.localdomain> <1157045360.4366.4.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8AA783E6-2640-4533-A085-129F636A448F@mac.com>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, akpm@osdl.org, okuji@enbug.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 0/6] RFC: fault-injection capabilities (v2)
Date: Thu, 31 Aug 2006 14:31:34 -0400
To: Josh Triplett <josht@us.ibm.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31, 2006, at 13:29:20, Josh Triplett wrote:
> On Thu, 2006-08-31 at 19:07 +0900, Akinobu Mita wrote:
>> This patch set provides some fault-injection capabilities.
>>
>> - kmalloc failures
>>
>> - alloc_pages() failures
>>
>> - disk IO errors
>>
>> We can see what really happens if those failures happen.
>
> Looks very useful for testing error paths; nice work.
>
> Should this perhaps taint the kernel when used?

It shouldn't; these are all failures that could quite possibly happen  
during normal operation even without this enabled, they're just a few  
orders of magnitude less likely (in most situations).

Cheers,
Kyle moffett

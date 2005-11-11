Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVKKWku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVKKWku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVKKWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:40:16 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:39099 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751294AbVKKWj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:39:58 -0500
Message-ID: <43751DB2.2050509@cs.wisc.edu>
Date: Fri, 11 Nov 2005 16:39:46 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] final pre -rc pieces of SCSI for 2.6.14
References: <1131745742.3505.47.camel@mulgrave>	 <20051111222341.GA20077@infradead.org> <1131748733.15249.1.camel@max>
In-Reply-To: <1131748733.15249.1.camel@max>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> On Fri, 2005-11-11 at 22:23 +0000, Christoph Hellwig wrote:
> 
>>On Fri, Nov 11, 2005 at 03:49:01PM -0600, James Bottomley wrote:
>>
>>>  o remove scsi_wait_req
>>
>>This requires '[PATCH] kill libata scsi_wait_req usage (make libata compile in
>>scsi-misc)' from Mike, because libata started to use this function in mainline
>>about the same time it was removed in scsi-misc.
> 
> 
> 
> My previous patch needed to included scsi_eh.h. Someone sent a patch in
> -mm to d othis. Here is my patch plus the scsi_eh.h include patch rolled
> into one if you need it.
> 
> rm scsi_wait_req() usage.
> 

oh yeah that patch was made agsint scsi-misc.

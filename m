Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVJXNvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVJXNvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVJXNvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:51:18 -0400
Received: from magic.adaptec.com ([216.52.22.17]:27063 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750956AbVJXNvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:51:18 -0400
Message-ID: <435CE6CA.4070704@adaptec.com>
Date: Mon, 24 Oct 2005 09:51:06 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Sergey Panov <sipan@sipan.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de> <20051022105815.GB3027@infradead.org> <1129994910.6286.21.camel@sipan.sipan.org> <20051022171943.GA7546@infradead.org>
In-Reply-To: <20051022171943.GA7546@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2005 13:51:11.0314 (UTC) FILETIME=[FE071B20:01C5D8A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/05 13:19, Christoph Hellwig wrote:
> On Sat, Oct 22, 2005 at 11:28:30AM -0400, Sergey Panov wrote:
> 
>> It is a mistake to think that you can not do a big rework and keep SCSI
>>sub-system stable. You just have to make sure the OLD way is supported
>>for as log as it is needed.
> 
> 
> No.  Rewriting something from scratch is horrible engineering practice.

Off Topic:
	Discourse on Christoph's "Rewriting something from scratch
		is horrible engineering practice"

Christoph,

Imagine a for ( ) { } loop spanning 5000 lines.  Imagine never using
functions to separate things.  But imagine that a _factory_ is using
this code on its production line and that code, although badly written,
does work and keeps the production line going and thousands of
people working.

They hire an engineer to make it _managable_ and supportable -- this
warrants understanding the production line, what the code does, what it
controls and how.  Understanding how the factory workers use it and what
they expect.  Understanding the code (which may not be as easy).  Then it
is rewritten so that it can be easily supported and maintained.

This is real life example.

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/

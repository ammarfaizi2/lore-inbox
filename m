Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUD3TRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUD3TRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUD3TRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:17:32 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:24488 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S265227AbUD3TRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:17:30 -0400
Message-ID: <4092A636.7050304@watson.ibm.com>
Date: Fri, 30 Apr 2004 15:17:10 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
References: <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 30 Apr 2004, Christoph Hellwig wrote:
> 
> 
>>I'd hate to see this in the kernel unless there's a very strong need
>>for it and no way to solve it at a nicer layer of abstraction, e.g.
>>userland virtual machines ala uml/umlinux.
> 
> 
> User Mode Linux could definitely be an option for implementing
> resource management, provided that the overhead can be kept
> low enough.

....and provided the groups of processes that are sought to be 
regulated as a unit are relatively static.


> For these purposes, "low enough" could be as much as 30%
> overhead, since that would still allow people to grow the
> utilisation of their server from a typical 10-20% to as
> much as 40-50%.
> 

In overhead, I presume you're including the overhead of running as 
many uml instances as expected number of classes. Not just the 
slowdown of applications because they're running under a uml instance 
(instead of running native) ?

I think UML is justified more from a fault-containment point of view 
(where overheads are a lower priority) than from a performance 
isolation viewpoint.

In any case, a 30% overhead would send a large batch of higher-end 
server admins running to get a stick to beat you with :-)





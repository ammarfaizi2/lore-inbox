Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUD3TsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUD3TsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUD3TsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:48:21 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:49319 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S265236AbUD3TsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:48:19 -0400
Message-ID: <4092AD60.1030809@watson.ibm.com>
Date: Fri, 30 Apr 2004 15:47:44 -0400
From: Shailabh <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Jeff Dike <jdike@karaya.com>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
References: <20040430174117.A13372@infradead.org> <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>
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
> 
> For these purposes, "low enough" could be as much as 30%
> overhead, since that would still allow people to grow the
> utilisation of their server from a typical 10-20% to as
> much as 40-50%.
> 


http://www.cl.cam.ac.uk/Research/SRG/netos/xen/performance.html

has some numbers comparing native Linux to UML (and against the Xen 
virtual machine monitor) but its on a 2.4 kernel.

Jeff, do you have any numbers for UML overhead in 2.6 ?

-- Shailabh


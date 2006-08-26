Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWHZVym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWHZVym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 17:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWHZVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 17:54:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17030 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750745AbWHZVyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 17:54:41 -0400
Message-ID: <44F0C312.1050300@redhat.com>
Date: Sat, 26 Aug 2006 17:54:26 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH 6/6] nfs: Enable swap over NFS
References: <20060825153709.24254.28118.sendpatchset@twins> <20060825153812.24254.9718.sendpatchset@twins> <20060826143622.GA5260@ucw.cz>
In-Reply-To: <20060826143622.GA5260@ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> Now that NFS can handle swap cache pages, add a swapfile method to allow
>> swapping over NFS.
>>
>> NOTE: this dummy method is obviously not enough to make it safe.
>> A more complete version of the nfs_swapfile() function will be present
>> in the next VM deadlock avoidance patches.
>>
>> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> We probably do not want to enable functionality before it is safe...

OTOH, if we never enable this, what motivation do we have to
make it safe? :)

Scratching an itch works, so maybe we ought to create an itch?

-- 
What is important?  What you want to be true, or what is true?

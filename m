Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSDSUdK>; Fri, 19 Apr 2002 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312889AbSDSUdJ>; Fri, 19 Apr 2002 16:33:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5714 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312790AbSDSUdJ>; Fri, 19 Apr 2002 16:33:09 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documenation/vm/numa
In-Reply-To: <Pine.LNX.4.44.0204190448070.8173-100000@skynet>
	<2809819807.1019168322@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Apr 2002 14:25:50 -0600
Message-ID: <m1n0vz4er5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> writes:
> 
> Note that there are two possible ways to define a pfn, in my mind.
> One would be page_phys_addr >> PAGE_SHIFT. The other would be the
> offset of the struct page for that page within the mythical mem_map
> array. I prefer the former, though it probably contradicts everyone
> else ;-) It's useful to have some way to pass around a 36 bit address
> inside a 32 bit field.

A page frame number (pfn) is definitely the former 
(page_phys_addr >> PAGE_SHIFT).

Eric

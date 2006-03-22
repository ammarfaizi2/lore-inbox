Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWCVPfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWCVPfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCVPfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:35:41 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:11145 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751289AbWCVPfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:35:40 -0500
In-Reply-To: <79fcd3fd1d13741c5d1cd3c6f5b326b9@cl.cam.ac.uk>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org> <44213333.6030404@yahoo.com.au> <79fcd3fd1d13741c5d1cd3c6f5b326b9@cl.cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <503082446ce33efbf163ad2af63bb0e1@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 30/35] Add generic_page_range() function
Date: Wed, 22 Mar 2006 15:35:09 +0000
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 14:33, Keir Fraser wrote:

> Okay, can you suggest a better one? That's the best I could come up 
> with that wasn't long winded.

How about apply_to_page_range()?

>
>> secondly, I think you confuse our (confusing) terminology: the page
>> that holds pte_ts is not the pte_page, the pte_page is the page that
>> a pte points to
>
> What should we call it? Essentially we want to be able to get the 
> physical address of a PTE in some cases, and passing struct page 
> pointer seemed the best way to be able to derive that. I can rename it 
> to something else vaguely plausible if the only problem is the 
> semantic clash with Linux's idiomatic use of pte_page.

Looks like pmd_page is correct?

  -- Keir


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWCVJ1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWCVJ1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWCVJ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:27:43 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:49611 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751157AbWCVJ1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:27:43 -0500
In-Reply-To: <44211019.60007@vmware.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org> <44211019.60007@vmware.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f406851555d46bdac6310f981bcd8193@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [RFC PATCH 30/35] Add generic_page_range() function
Date: Wed, 22 Mar 2006 09:27:58 +0000
To: Zachary Amsden <zach@vmware.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:51, Zachary Amsden wrote:

>> Although this interface is intended to be useful in a wide range of
>> situations, it is currently used specifically by several Xen
>> subsystems, for example: to ensure that pagetables have been allocated
>> for a virtual address range, and to construct batched special
>> pagetable update requests to map I/O memory (in ioremap()).
>>
>
> This interface is great, and highly useful.  But it doesn't seem to be 
> able to work on native hardware, as it doesn't support large pages.

Ah, good point. I'll add that.

  -- Keir


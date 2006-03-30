Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWC3XSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWC3XSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWC3XSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:18:06 -0500
Received: from fmr19.intel.com ([134.134.136.18]:7892 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751132AbWC3XSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:18:05 -0500
Message-ID: <442C672A.2030707@ichips.intel.com>
Date: Thu, 30 Mar 2006 15:18:02 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] updated InfiniBand 2.6.17 merge plans
References: <ada7j6f8xwi.fsf@cisco.com> <ada1wwj1r7r.fsf@cisco.com>
In-Reply-To: <ada1wwj1r7r.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  * RDMA CM.  In my git tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git rdma_cm
> 
>    None of the users of this code look are to merge, and it looks like
>    there's some changes in the design happening now.  Seems like this
>    can and should wait for 2.6.18.

Does it make sense to merge the first two patches of that patch series?

1. Provide common handling for marshalling data between userspace clients and
kernel mode Infiniband drivers.

2. Extend the Infiniband CM to include private data comparisons as part of its
connection request matching process.

This would make it easier to keep the openib tree in sync with the kernel.

- Sean

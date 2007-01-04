Return-Path: <linux-kernel-owner+w=401wt.eu-S1030197AbXADTf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbXADTf3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbXADTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:35:29 -0500
Received: from rtr.ca ([64.26.128.89]:1731 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030197AbXADTf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:35:28 -0500
Message-ID: <459D56FE.5080600@rtr.ca>
Date: Thu, 04 Jan 2007 14:35:26 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Hua Zhong <hzhong@gmail.com>, Christoph Hellwig <hch@infradead.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <003f01c7302f$e72164b0$0200a8c0@nuitysystems.com> <Pine.LNX.4.64.0701041911470.27405@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701041911470.27405@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 4 Jan 2007, Hua Zhong wrote:
>> So I'd argue that it makes more sense to support O_DIRECT
>> on tmpfs as the memory IS the backing store.
> 
> A few more voices in favour and I'll be persuaded. 

I see no reason to restrict it as is currently done.

Policy belongs in userspace, not in the kernel,
so long as the code impact is miniscule.

Cheers

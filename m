Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWASSvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWASSvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWASSvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:51:38 -0500
Received: from fmr20.intel.com ([134.134.136.19]:6110 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161208AbWASSvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:51:38 -0500
Message-ID: <43CFDF5F.5060409@ichips.intel.com>
Date: Thu, 19 Jan 2006 10:50:07 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
References: <1137631411.4757.218.camel@serpentine.pathscale.com>	<m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>	<1137688158.3693.29.camel@serpentine.pathscale.com> <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>No.  If you're running a full IB stack, we provide the usual IB subnet
>>management facilities, and you can run OpenSM to manage your subnet.  If
>>you're *not*, which is the case I'm concerned with here, it makes no
>>sense to replicate the byzantine IB management interfaces in order to do
>>a handful of simple things that aren't even tied to the higher-level IB
>>protocols.
> 
> Is it the stack that is byzantine?  Or the interface too it.
> What I thinking untimately is there should be something about as
> simple as af_packet in the kernel (but at the IB/rdma) layer that
> gives you the help you need.

I'm not familiar with the driver, but would the lower level verbs interfaces 
work for this?  Could you just post whatever datagrams that you want directly to 
your management QPs?

- Sean

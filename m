Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161426AbWASVKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161426AbWASVKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWASVKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:10:33 -0500
Received: from fmr17.intel.com ([134.134.136.16]:39861 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161426AbWASVKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:10:32 -0500
Message-ID: <43CFFFCB.7060002@ichips.intel.com>
Date: Thu, 19 Jan 2006 13:08:27 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@pathscale.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
References: <1137631411.4757.218.camel@serpentine.pathscale.com>	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>	 <1137688158.3693.29.camel@serpentine.pathscale.com>	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>	 <43CFDF5F.5060409@ichips.intel.com> <1137696901.3693.66.camel@serpentine.pathscale.com>
In-Reply-To: <1137696901.3693.66.camel@serpentine.pathscale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> Our lowest-level driver works in the absence of any IB support being
> compiled into the kernel, so in that situation, there are no QPs or any
> other management infrastructure present at all.  All of that stuff lives
> in a higher layer, in which situation the cut-down subnet management
> agent doesn't get used, and something like OpenSM is more appropriate.

I'm struggling to understand what your card does then.  From this, it sounds 
like a standard network card that just happens to use IB physicals.  Do you just 
send raw packets?  How is the LRH formatted by your card?  I.e. what's setting 
up the dlid, slid, vl, etc.?  Can your card interoperate with other IB devices 
on the network when running in this mode?

- Sean

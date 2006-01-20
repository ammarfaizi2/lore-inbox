Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWATADN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWATADN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWATADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:03:13 -0500
Received: from fmr17.intel.com ([134.134.136.16]:6890 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161395AbWATADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:03:12 -0500
Message-ID: <43D02888.30605@ichips.intel.com>
Date: Thu, 19 Jan 2006 16:02:16 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@pathscale.com>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
References: <1137631411.4757.218.camel@serpentine.pathscale.com>	<20060119025741.GC15706@kroah.com>	<1137646957.25584.17.camel@localhost.localdomain>	<20060119053940.GB21467@kroah.com>	<1137649988.25584.67.camel@localhost.localdomain>	<20060119225716.GB27689@kroah.com> <1137714259.22241.12.camel@localhost.localdomain>
In-Reply-To: <1137714259.22241.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> We are not really in the RDMA camp.  Our facility looks more like "when
> this kind of message comes in, be sure that it shows up at this point in
> my address space", which does not match RDMA semantics.

A lot of people mean QP-like semantics when they talk about "RDMA", rather than 
the RDMA operation itself.  I.e. pre-posted receive buffers associated with a 
particular user-space process.

That aside, conceptually, I see little difference between RDMA semantics versus 
the facility that you describe.  The main difference is the complexity of the 
header and the checks done against it.

- Sean

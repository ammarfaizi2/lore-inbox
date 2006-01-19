Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWASSzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWASSzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWASSzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:55:05 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50922 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161258AbWASSzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:55:02 -0500
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43CFDF5F.5060409@ichips.intel.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	 <1137688158.3693.29.camel@serpentine.pathscale.com>
	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	 <43CFDF5F.5060409@ichips.intel.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 19 Jan 2006 10:55:01 -0800
Message-Id: <1137696901.3693.66.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 10:50 -0800, Sean Hefty wrote:

> I'm not familiar with the driver, but would the lower level verbs interfaces 
> work for this?  Could you just post whatever datagrams that you want directly to 
> your management QPs?

Our lowest-level driver works in the absence of any IB support being
compiled into the kernel, so in that situation, there are no QPs or any
other management infrastructure present at all.  All of that stuff lives
in a higher layer, in which situation the cut-down subnet management
agent doesn't get used, and something like OpenSM is more appropriate.

	<b


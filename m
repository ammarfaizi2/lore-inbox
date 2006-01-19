Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWASFRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWASFRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWASFRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:17:23 -0500
Received: from mx.pathscale.com ([64.160.42.68]:62623 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161016AbWASFRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:17:23 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
In-Reply-To: <20060118.171716.04998471.davem@davemloft.net>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <20060118.164839.74431051.davem@davemloft.net>
	 <1137633256.4757.225.camel@serpentine.pathscale.com>
	 <20060118.171716.04998471.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 21:17:01 -0800
Message-Id: <1137647821.25584.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 17:17 -0800, David S. Miller wrote:

> It's going to give you strict typing, and extensible attributes for
> the configuration attributes you define.  So if you determine later
> "oh we need to add this knob for changing X" you can do that without
> breaking the existing interface.

Wow.  OK, that is not immediately obvious from reading the code.  The
only modules in drivers/ that seem to use netlink are iscsi, connector,
and w1.  It's more extensive in net/, I see.

> Try not to get discouraged, give it a shot :)

It's not obvious what chunk of the the tree is a good example to follow.
Just look what happened when I suggested to Greg that I use the Dell
firmware loader as an example :-)

The closest approximation I can find to documentation is something Neil
Horman wrote over a year ago:

http://people.redhat.com/nhorman/papers/netlink.pdf

And a "this module does a particularly natty job that all coders would
do well to emulate" pointer would be most welcome.

I notice that libnetlink appears to have disappeared without a trace,
along with Alexey.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVA1DAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVA1DAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 22:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVA1DAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 22:00:53 -0500
Received: from ozlabs.org ([203.10.76.45]:24987 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261412AbVA1DAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 22:00:49 -0500
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>,
       David Brownell <david-b@pacbell.net>,
       jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org,
       david+challenge-response@blue-labs.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, ahaas@airmail.net
In-Reply-To: <41F99656.5040304@trash.net>
References: <200501232251.42394.david-b@pacbell.net>
	 <priv$1106815487.koan@shadow.banki.hu>
	 <200501271128.48411.david-b@pacbell.net>
	 <200501271511.58086.david-b@pacbell.net>
	 <20050127154150.360f95e2.davem@davemloft.net>  <41F99656.5040304@trash.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 14:00:50 +1100
Message-Id: <1106881251.18360.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 02:33 +0100, Patrick McHardy wrote:
> David S. Miller wrote:
> 
> >I've forwarded this to netfilter-devel for inspection.
> >Thanks for collecting all the data points so well.
> >
> Here is the fix for everyone. Please report back if it doesn't
> solve the problem. Thanks.

Verified by nfsim (the ICMP tests used UDP, I've just added TCP and
ICMP, and will do SCTP).

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman


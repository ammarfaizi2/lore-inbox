Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWCJPfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWCJPfl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWCJPfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:35:41 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:6036 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1751432AbWCJPfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:35:40 -0500
Subject: Re: [UPDATED PATCH] Re: [Lse-tech] Re: [Patch 7/7] Generic netlink
	interface (delay	accounting)
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
In-Reply-To: <1142002433.5298.42.camel@jzny2>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141029060.5785.77.camel@elinux04.optonline.net>
	 <1141045194.5363.12.camel@localhost.localdomain>
	 <4403608E.1050304@watson.ibm.com>
	 <1141652556.5185.64.camel@localhost.localdomain>
	 <440C6AAA.9030301@watson.ibm.com>
	 <1141742282.5171.55.camel@localhost.localdomain>
	 <440F52FF.30908@watson.ibm.com>  <20060309143759.GA4653@in.ibm.com>
	 <1142002433.5298.42.camel@jzny2>
Content-Type: text/plain
Organization: unknown
Date: Fri, 10 Mar 2006 10:35:34 -0500
Message-Id: <1142004934.5255.3.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-03 at 09:53 -0500, jamal wrote:

> 
> a) shipping of the taskstats from kernel to user-space asynchronously to
> all listeners on multicast channel/group TASKSTATS_LISTEN_GRP
> at the point when some process exits.
> b) responding to queries issued by the user to the kernel for taskstats
> of a particular defined tgid and/or pid combination. 
> 
> Did i summarize your goals correctly?
> 
> So lets stat with #b:
> i) the message is multicast; there has to be a user space app registered
> to the multicast group otherwise nothing goes to user space.

I mispoke:
The above applies to #a. 
For #b, the message from/to kernel to user is unicast.


cheers,
jamal



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264283AbUENBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUENBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUENBO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:14:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5521 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264283AbUENBOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:14:54 -0400
Date: Fri, 14 May 2004 10:13:47 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: Node Hotplug Support
In-reply-to: <1084430738.3189.1.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040514101347.7cbf99f4.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
 <1083944945.23559.1.camel@nighthawk>
 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
 <1084167941.28602.478.camel@nighthawk>
 <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
 <1084413887.974.7.camel@nighthawk>
 <20040513153505.21c5fc15.tokunaga.keiich@jp.fujitsu.com>
 <1084430738.3189.1.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 23:45:38 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Wed, 2004-05-12 at 23:35, Keiichiro Tokunaga wrote:
> > LHNS is focusing on "container device hotplug". Container device
> > could contain CPUs, memory, and/or IO devices.  Container device
> > could contain only IO devices.  In this case, LHNS cannot use
> > $NODED/control/online (NUMA stuff) for the container device.
> 
> So, why not expose your containers in the same way that all of the other
> NUMA node information is exported?  What makes your NUMA containers
> different from all of the other flavors of NUMA implementations in
> Linux?
> 
> > By the way, what happen when you issue
> > "echo 0 > $NODEDIR/control/online"?  Can you detach it
> > from the system after echo-ing?
> 
> Well, since it doesn't exist yet... Sure :)

The same way as you described in your previous email seems
work for a container device if we have $CONTAINERD/online.
Anyway, I feel we need to be more specific about implementation.
Is there already any information that I can access?

Thanks,
Kei

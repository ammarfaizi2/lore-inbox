Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUEMGpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUEMGpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUEMGpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:45:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:30852 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263776AbUEMGpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:45:41 -0400
Subject: Re: Node Hotplug Support
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net
In-Reply-To: <20040513153505.21c5fc15.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
	 <1083944945.23559.1.camel@nighthawk>
	 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
	 <1084167941.28602.478.camel@nighthawk>
	 <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
	 <1084413887.974.7.camel@nighthawk>
	 <20040513153505.21c5fc15.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1084430738.3189.1.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 23:45:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 23:35, Keiichiro Tokunaga wrote:
> LHNS is focusing on "container device hotplug". Container device
> could contain CPUs, memory, and/or IO devices.  Container device
> could contain only IO devices.  In this case, LHNS cannot use
> $NODED/control/online (NUMA stuff) for the container device.

So, why not expose your containers in the same way that all of the other
NUMA node information is exported?  What makes your NUMA containers
different from all of the other flavors of NUMA implementations in
Linux?

> By the way, what happen when you issue
> "echo 0 > $NODEDIR/control/online"?  Can you detach it
> from the system after echo-ing?

Well, since it doesn't exist yet... Sure :)

-- Dave


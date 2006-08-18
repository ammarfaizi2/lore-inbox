Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWHRTUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWHRTUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHRTUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:20:54 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:1923 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S932240AbWHRTUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:20:54 -0400
Message-ID: <44E61227.9020006@nortel.com>
Date: Fri, 18 Aug 2006 13:16:55 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: sekharan@us.ibm.com, riel@redhat.com, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, hch@infradead.org, saw@sw.ru,
       alan@lxorguk.ukuu.org.uk, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, xemul@openvz.org,
       mingo@elte.hu, devel@openvz.org, ak@suse.de
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru> <1155752277.22595.70.camel@galaxy.corp.google.com> <1155755069.24077.392.camel@localhost.localdomain> <1155756170.22595.109.camel@galaxy.corp.google.com> <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org> <20060818120809.B11407@castle.nmd.msu.ru> <1155912348.9274.83.camel@localhost.localdomain> <20060818094248.cdca152d.akpm@osdl.org> <1155925065.26155.17.camel@linuxchandra> <20060818115624.fd875624.pj@sgi.com>
In-Reply-To: <20060818115624.fd875624.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Aug 2006 19:17:00.0785 (UTC) FILETIME=[E1852610:01C6C2FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> The fair sharing model (such as in CKRM) that strives for maximum
> utilization of resources respecting priorities and min/max limits is
> (I suppose) quite useful for certain workloads and customers.
> 
> The hardwall NUMA placement model (such as in cpusets) that strives
> for maximum processor and memory isolation between jobs, preferring
> to leave allocated resources unused rather than trying to share them,
> is also quite useful for some.  Customers with 256 thread, one or
> two day long run time, -very- tightly coupled huge OpenMP Fortran
> jobs that need to complete within a few percent of the same time,
> every runtime, demand it.

Hypothetically, if you can guarantee that those threads get a specified 
amount of time, but may possibly get *more* cpu time and thus finish 
faster, what's the problem?

Chris

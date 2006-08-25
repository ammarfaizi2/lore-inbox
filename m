Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWHYRYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWHYRYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWHYRYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:24:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5515 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030231AbWHYRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:24:08 -0400
Date: Fri, 25 Aug 2006 10:23:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       anton@samba.org, simon.derr@bull.net, nathanl@austin.ibm.com,
       akpm@osdl.org, y-goto@jp.fujitsu.com
Subject: Re: memory hotplug - looking for good place for cpuset hook
Message-Id: <20060825102348.bb53d307.pj@sgi.com>
In-Reply-To: <1156517885.12011.170.camel@localhost.localdomain>
References: <20060825015359.1c9eab45.pj@sgi.com>
	<20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
	<1156517885.12011.170.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Gets it a wee bit farther from memory hotplug anyway. ;)

huh?  Where Kame suggested is just a couple lines of code and one test
below where I suggested.  How is this farther from memory hotplug, as
it still seems to be in one of the main memory hotplug routines -
add_memory()?

And why would I want to place a hook that tracks hotplug added memory
nodes 'farther from memory hotplug'?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

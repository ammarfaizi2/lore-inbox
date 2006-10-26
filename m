Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423618AbWJZQo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423618AbWJZQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423614AbWJZQo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:44:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60368 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423610AbWJZQo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:44:57 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200610261644.k9QGipAf21995445@clink.americas.sgi.com>
Subject: Re: [patch] Mixed Madison and Montecito system support
To: suresh.b.siddha@intel.com (Siddha, Suresh B)
Date: Thu, 26 Oct 2006 11:44:51 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson), tony.luck@intel.com (Luck Tony),
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061025164253.A21790@unix-os.sc.intel.com> from "Siddha, Suresh B" at Oct 25, 2006 04:42:53 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> 
> I added it so that these entries will not confuse users of a non-smt/mc
> systems. But mixed type of processors and cpu hotplug really complicates the
> things..

Yes, it does.  :-)
 
> May be a check of something like "is this platform capable of
> supporting any multi-core/multi-threaded processor package?" helps..
> 
> As there is no well defined mechanism to find out that and for simplicity
> reasons, we should probably go with Tony's suggestion.
> 
> Russ I can post a patch, removing both smt_capable() and mc_capable()
> checks.

Yes, please do.

> Today this sysfs variable is not documented. But when it happens, we
> need to clearly document that these variables have no meaning when
> the system doesn't have cpus with threads/cores.


-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com

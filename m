Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWBJQa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWBJQa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBJQa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:30:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25050 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932153AbWBJQay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:30:54 -0500
Subject: Re: [Lhms-devel] [RFC/PATCH: 001/010] Memory hotplug for new nodes
	with pgdat allocation. (pgdat allocation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <20060210223757.C530.Y-GOTO@jp.fujitsu.com>
References: <20060210223757.C530.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 08:30:41 -0800
Message-Id: <1139589041.9209.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> +       NODE_DATA(nid)->kswapd = kthread_create(kswapd, NODE_DATA(nid), "kswapd%d", nid); 

Can this fail?

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWBJQ3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWBJQ3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWBJQ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:29:04 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5588 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932140AbWBJQ3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:29:01 -0500
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
Date: Fri, 10 Feb 2006 08:28:47 -0800
Message-Id: <1139588927.9209.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> 
> +       if (!pgdat){
> +               printk("%s node_data allocation failed\n",
> __FUNCTION__);
> +               return -ENODEV;
> +       } 

Needs a printk level, please.

-- Dave


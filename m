Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUFYUqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUFYUqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUFYUqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:46:01 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:61625 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S266615AbUFYUpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:45:51 -0400
Date: Fri, 25 Jun 2004 13:45:30 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] Re: Merging Nonlinear and Numa style memory hotplug
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <1088189973.29059.231.camel@nighthawk>
References: <20040625114720.2935.YGOTO@us.fujitsu.com> <1088189973.29059.231.camel@nighthawk>
Message-Id: <20040625121110.2937.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are you sure that all architectures need phys_section?
> 
> You don't *need* it, but the alternative is a scan of the mem_section[]
> array, which would be much, much slower.
> 
> Do you have an idea for an alternate implementation?

I didn't find that scan of the mem_section[] is necessary.
I thought just that mem_section index = phys_section index.
May I ask why scan of mem_section is necessary?
I might still have misunderstood something.


-- 
Yasunori Goto <ygoto at us.fujitsu.com>



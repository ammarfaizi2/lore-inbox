Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUA1WI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUA1WI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:08:26 -0500
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:30449 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S266198AbUA1WIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:08:25 -0500
Date: Wed, 28 Jan 2004 14:08:13 -0800
From: Yasunori Goto <ygoto@fsw.fujitsu.com>
To: colpatch@us.ibm.com
Subject: Re: [PATCH] Remove memblks from the kernel
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, akpm@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <4016DE81.9080507@us.ibm.com>
References: <237770000.1074843321@[10.10.2.4]> <4016DE81.9080507@us.ibm.com>
Message-Id: <20040128135302.2C5B.YGOTO@fsw.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> Martin J. Bligh wrote:
> > This patch removes memblks from the kernel ... we don't use them, and
> > the NUMA API that was planning to use them when they were originally 
> > designed isn't going to use them anymore. They're just unnecessary 
> > added complexity now ... time for them to go.
> > 
> > There's a slight complication in that ia64 uses something with a similar
> > name for part of its memory layout, but Jes Sorensen kindly untangled them
> > from each other for us. The patch with his modifications is below. Jes 
> > tested it on ia64, and I testbuilt it with every config in my arsenal.
> > 
> > Please apply ... thanks,
> > 
> > M.
> 
> As the unfortunate soul who pushed this whole memblk concept way back 
> when, I'll add my support for their removal.  The things I envisioned 
> happening with memblks never materialized and so Martin is right, now 
> they're just taking up space.  Adios memblks, we barely knew ye.

OK. 
I feel I have to agree removing memblk, 
because my opinion is just concept and I don't have any patch yet.
If memblks will be needed again when we will be able to 
support partial failure of memory, I will post the patch.

Good bye and Sayonara memblks.
I'm glad that some person heard my opinion.

Thanks.

-- 
Yasunori Goto <ygoto at fsw.fujitsu.com>


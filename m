Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUA0WBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUA0WBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:01:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:44004 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263903AbUA0WBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:01:19 -0500
Message-ID: <4016DE81.9080507@us.ibm.com>
Date: Tue, 27 Jan 2004 13:56:17 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: akpm@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove memblks from the kernel
References: <237770000.1074843321@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> This patch removes memblks from the kernel ... we don't use them, and
> the NUMA API that was planning to use them when they were originally 
> designed isn't going to use them anymore. They're just unnecessary 
> added complexity now ... time for them to go.
> 
> There's a slight complication in that ia64 uses something with a similar
> name for part of its memory layout, but Jes Sorensen kindly untangled them
> from each other for us. The patch with his modifications is below. Jes 
> tested it on ia64, and I testbuilt it with every config in my arsenal.
> 
> Please apply ... thanks,
> 
> M.

As the unfortunate soul who pushed this whole memblk concept way back 
when, I'll add my support for their removal.  The things I envisioned 
happening with memblks never materialized and so Martin is right, now 
they're just taking up space.  Adios memblks, we barely knew ye.

Cheers!

-Matt


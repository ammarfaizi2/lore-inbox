Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292576AbSCFAwY>; Tue, 5 Mar 2002 19:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292583AbSCFAwF>; Tue, 5 Mar 2002 19:52:05 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2490 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292576AbSCFAvp>;
	Tue, 5 Mar 2002 19:51:45 -0500
Message-ID: <3C856818.4050005@us.ibm.com>
Date: Tue, 05 Mar 2002 16:51:36 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
In-Reply-To: <Pine.GSO.4.21.0203051935160.18755-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Denied.  You can trivially do that in ext2_read_inode() and ext2_new_inode().
Good point.  That makes it much easier.

> ext2 patches _MUST_ get testing in 2.5 before they can go into 2.4.  At
> the very least a month, preferably - two.  Until then consider them vetoed
> for 2.4, no matter how BKL brigade feels about their crusade.
ChangeSet@1.290  2002-02-11 21:26:50-08:00  viro@psu.edu

So, it has been almost a month.  Do you plan to port these changes back 
to 2.4 yourself?



-- 
Dave Hansen
haveblue@us.ibm.com


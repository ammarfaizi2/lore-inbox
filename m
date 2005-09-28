Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVI1UzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVI1UzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVI1UzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:55:07 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:12563 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750754AbVI1UzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:55:06 -0400
Message-ID: <433B032E.8090900@tmr.com>
Date: Wed, 28 Sep 2005 16:55:10 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wilson Li <yongshenglee@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
References: <20050928192934.56067.qmail@web34114.mail.mud.yahoo.com>
In-Reply-To: <20050928192934.56067.qmail@web34114.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilson Li wrote:
> Hi,
> 
> I am trying to port several third party kernel modules from kernel
> 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of modules, it
> works perfectly in 2.6. But there's one huge kernel module which size
> is about 2.7M bytes (size reported by lsmod after insmod), and it
> takes about 90 seconds to load this module before init_module starts.
> I did not notice there's such obvious delay in 2.4 kernel.

How big is the module on disk? That is, what is the disk to memory 
transfer size. Really 2.7MB, or is there a lot of uninitialized storage?
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCAG7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCAG7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCAG7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:59:31 -0500
Received: from wasp.net.au ([203.190.192.17]:3746 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261263AbVCAG70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:59:26 -0500
Message-ID: <422412AB.8080907@wasp.net.au>
Date: Tue, 01 Mar 2005 10:58:51 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: lkml <linux-kernel@vger.kernel.org>,
       RAID Linux <linux-raid@vger.kernel.org>
Subject: Re: Raid-6 hang on write.
References: <421DE9A9.4090902@wasp.net.au>	<421F4629.5080309@wasp.net.au> <16930.45319.682534.351648@cse.unsw.edu.au>
In-Reply-To: <16930.45319.682534.351648@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Could you please confirm if there is a problem with
>     2.6.11-rc4-bk4->bk10
> 
> as reported, and whether it seems to be the same problem.

Ok.. are we all ready? I had applied your development patches to all my vanilla 2.6.11-rc4-* 
kernels. Thus they all exhibited the same problem in the same way as -mm1. <Smacks forehead against 
wall repeatedly>

I had applied the patch to correct the looping resync issue with too many failed drives, and just 
continued and applied all the other patches also.

I have been unable to reproduce the fault using a vanilla 2.6.11-rc5-bk2 kernel.

Oh well, at least we now know about a bug in the -mm patches.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams

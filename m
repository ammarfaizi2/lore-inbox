Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWIOEZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWIOEZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 00:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWIOEZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 00:25:12 -0400
Received: from main.gmane.org ([80.91.229.2]:36583 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750979AbWIOEZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 00:25:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bhavani <bhavani11@rediffmail.com>
Subject: Re: SDIO card support in Linux
Date: Thu, 14 Sep 2006 12:01:00 +0000 (UTC)
Message-ID: <loom.20060914T135039-642@post.gmane.org>
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>  <44F73E37.6030602@drzeus.cx> <f71aedf40609051651k5d36d4fdkb6020685fc366983@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.187.132.50 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050716 Firefox/1.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



madhu chikkature <crmadhu210 <at> gmail.com> writes:

> 
> Hi Pierre,
> 
> Here is some piece of code that i wrote for SDIO. I use 2.6.10 kernel
> and hence i can not really take a diff between the latest kernel
> version. But this is not really a patch. So, You can just comment on
> my code. I might later on work on the latest kernel versions based on
> your comment.I see that there are more discussions happening. Please
> pont to me if you have some code already written.
> 
> After your previous mail, i see that i can remove the support for CMD3
> seperately for SDIO and do it the SD way. But i am not sure how to
> maintain the list of SDIO cards seperately.Also some hardware as our
> omap does, can support multiple MMC slots, in such cases one slot can
> have SDIO and the other MMC. The core needs to cliam the cards from
> different lists. So you may see some not so correct parts in my code.
> 
> I am on the Texas Instruments MMC/SD/SDIO controller on the omap2 platform.
> 
> Regards,
> Madhu

Hi Madhu,
I hve omap2420,Tsunami board n i'm trying to bring up stack for sdio card.
Once i give IO_RW_EXTENDED the system gets hanged. I find it bit difficult to
fix it. Is there anything i'hve to change in host driver code. Please help me.

Thanks,
Bhavani



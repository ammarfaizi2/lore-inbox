Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVJ2A3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVJ2A3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJ2A3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:29:12 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:52997 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750912AbVJ2A3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:29:11 -0400
Message-ID: <4362C255.30600@oxley.org>
Date: Sat, 29 Oct 2005 01:29:09 +0100
From: Felix Oxley <lkml@oxley.org>
User-Agent: Thunderbird 1.4.1 (Macintosh/20051006)
MIME-Version: 1.0
To: Felix Oxley <lkml@oxley.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com> <4362BFFC.9050202@oxley.org>
In-Reply-To: <4362BFFC.9050202@oxley.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley wrote:
> Chen, Kenneth W wrote:
>  > Kernel performance data for 2.6.14 (released yesterday) is updated at:
>  > http://kernel-perf.sourceforge.net
>  >
>  > As expected, results are within run variation compares to 2.6.14-rc5.
>  > No significant deviation found compare to 2.6.14-rc5
>  >
> 
> There seems to be some regression here:
> 
> System: 4P Xeon
> Test:Result Group 8
> Metric: 64KB_4_fread
> Result:      +1.9%         -15%
> Kernel: 2.6.14-rc4 vs 2.6.14-rc4-git4
> 
> System: 2P Xeon
> Test:Result Group 7
> Metric: ODIRECT
> Kernel: 2.6.14-rc5 vs 2.6.14-rc5-git3
> Summary: Write has increased whereas Read has decreased by 4-5 %
> 
> 

Something went horribly wrong with this test between 2.6.13 and 
2.6.13-git2 (it has never recovered):

System: 4P Itanium
Test:Result Group 1
Metric: VolcanoMark
Result:      -3%         -10%
Kernel: 2.6.13 vs 2.6.13-git2

Does anybody know the cause of this?

regards,
Felix

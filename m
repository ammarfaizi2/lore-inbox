Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVJ2ATL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVJ2ATL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJ2ATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:19:11 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:32528 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750905AbVJ2ATK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:19:10 -0400
Message-ID: <4362BFFC.9050202@oxley.org>
Date: Sat, 29 Oct 2005 01:19:08 +0100
From: Felix Oxley <lkml@oxley.org>
User-Agent: Thunderbird 1.4.1 (Macintosh/20051006)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com>
In-Reply-To: <200510282344.j9SNihg27345@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
 > Kernel performance data for 2.6.14 (released yesterday) is updated at:
 > http://kernel-perf.sourceforge.net
 >
 > As expected, results are within run variation compares to 2.6.14-rc5.
 > No significant deviation found compare to 2.6.14-rc5
 >

There seems to be some regression here:

System: 4P Xeon
Test:Result Group 8
Metric: 64KB_4_fread
Result:      +1.9%         -15%
Kernel: 2.6.14-rc4 vs 2.6.14-rc4-git4

System: 2P Xeon
Test:Result Group 7
Metric: ODIRECT
Kernel: 2.6.14-rc5 vs 2.6.14-rc5-git3
Summary: Write has increased whereas Read has decreased by 4-5 %


Any thoughts?

regards,
Felix



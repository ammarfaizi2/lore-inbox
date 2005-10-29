Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVJ2A3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVJ2A3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVJ2A3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:29:20 -0400
Received: from fmr21.intel.com ([143.183.121.13]:40610 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750915AbVJ2A3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:29:19 -0400
Message-Id: <200510290029.j9T0TFg27980@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Felix Oxley'" <lkml@oxley.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel performance update - 2.6.14
Date: Fri, 28 Oct 2005 17:29:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXcH2MrkLzAIwbjTqm26hp34lmHHQAABpNQ
In-Reply-To: <4362BFFC.9050202@oxley.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley wrote on Friday, October 28, 2005 5:19 PM
> Chen, Kenneth W wrote:
> > Kernel performance data for 2.6.14 (released yesterday) is updated at:
> > http://kernel-perf.sourceforge.net
> >
> > As expected, results are within run variation compares to 2.6.14-rc5.
> > No significant deviation found compare to 2.6.14-rc5
> >
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
> Any thoughts?

Not on top of my head at the moment. These are iozone workload, we
will investigate these.

- Ken


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUG2MOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUG2MOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUG2MOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:14:10 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:15309 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264412AbUG2MOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:14:07 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091095341.4359.0.camel@teapot.felipe-alfaro.com>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
	 <1091061983.8867.95.camel@laptop.cunninghams>
	 <1091095341.4359.0.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091103080.2703.6.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 22:11:21 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 20:02, Felipe Alfaro Solana wrote:
> > It doesn't look like I've touched any of those threads. I have doubts
> > about irqd/0 (is that kirqd reworked?), so you might try making setting
> > PF_NOFREEZE and seeing if it makes a difference. I haven't done the
> > switch to rc2-mm1 yet, so haven't gotten to those issues.
> 
> kirqd is voluntary-preempt patch by Ingo Molnar. I have also applied
> several other patches, like Con's Staircase scheduler policy and some
> latency fixes.

Okay. So, just to make sure I understand you correctly, suspending works
fine with all of these other patches added and adding the extra
refrigerator calls breaks it. Are you at all able to narrow it down to a
particular change?

Regards,

Nigel


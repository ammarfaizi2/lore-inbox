Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVAMJp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVAMJp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 04:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVAMJp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 04:45:29 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:2741 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261324AbVAMJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 04:45:22 -0500
Date: Thu, 13 Jan 2005 10:45:37 +0100
From: Sander <sander@humilis.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: NUMA or not on dual Opteron (was: Re: Linux 2.6.11-rc1)
Message-ID: <20050113094537.GB2547@favonius>
Reply-To: sander@humilis.net
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <200501121824.44327.rathamahata@ehouse.ru> <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
X-Uptime: 09:57:10 up 3 days, 11:30, 26 users,  load average: 1.02, 1.01, 1.00
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote (ao):
> On Wed, 12 Jan 2005, Sergey S. Kostyliov wrote:
> > 2.6.10-rc1 hangs at boot stage for my dual opteron machine
> 
> Oops, yes. There's some recent NUMA breakage - either disable
> CONFIG_NUMA, or apply the patches that Andi Kleen just posted on the
> mailing list (the second option much preferred, just to verify that
> yes, that does fix it).

I was under the impression that NUMA is useful on > 2-way systems only.
Is this true, and if not, under what circumstances is NUMA useful on
2-way Opteron systems?

In other words: why should one want NUMA to be enabled or disabled for
dual Opteron?

Thanks in advance.

-- 
Humilis IT Services and Solutions
http://www.humilis.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTEKHn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 03:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTEKHn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 03:43:56 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:61974 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262252AbTEKHnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 03:43:55 -0400
From: Jos Hulzink <josh@stack.nl>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
Date: Sun, 11 May 2003 12:00:31 +0200
User-Agent: KMail/1.5
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]>
In-Reply-To: <7750000.1052619248@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305111200.31242.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 May 2003 04:14, Martin J. Bligh wrote:
>
> Could you test out this patch from Keith Mannthey if you're having trouble?
> It makes irq balance a config option, which makes it easier to disable.
> Various people have requested it, but I don't have a box to test it on ;-(
> Pulled out of -mjb tree, but should go onto mainline easily.
>
> M.
>

For 2.5.68, this patch isn't needed, the noirqbalance command line option 
works fine. I'll test it though, for IMHO irq balancing really should be an 
option, if not deleted at all. (anyone who actually gained performance with 
this ? Maybe it only works on cpus that are fast enough to handle all 
interrutps without performance going down)

For the Mandrake 2.4.21-0.13mdk kernel, there is no noirqbalance option in the 
kernel. I tried to contact the Mandrake guys about this, but unfortunately 
their response is 0. This patch also fails badly, and I haven't decided yet 
wether I'm willing to help a company which doesn't seem to care at all and 
uses pre-kernels in their distribution.

Jos

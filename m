Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268262AbUICTSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268262AbUICTSa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269691AbUICTSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:18:06 -0400
Received: from hera.kernel.org ([63.209.29.2]:24045 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S269771AbUICTRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:17:07 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2.6] watch64: generic variable monitoring system
Date: Fri, 3 Sep 2004 12:16:57 -0700
Organization: Open Source Development Lab
Message-ID: <20040903121657.355a6a8b@dell_ss3.pdx.osdl.net>
References: <200409031307.01240.jeffpc@optonline.net>
	<200409031319.24863.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1094239018 21841 172.20.1.60 (3 Sep 2004 19:16:58 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 3 Sep 2004 19:16:58 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2004 13:19:24 -0400
"Josef 'Jeff' Sipek" <jeffpc@optonline.net> wrote:

> The watch64 system allows the programmer to specify the approximate interval
> at which he wants his variables checked. If he tries to specify shorter
> interval than the minimum a default value of HZ/10 is used. To minimize
> locking, RCU and seqlock are used. On 64-bit systems, all is optimized away.
> 
> The following patch can be also pulled from http://jeffpc.bkbits.net/watch64-2.6
> 
> Josef "Jeff" Sipek.
> 
> Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>

- Seems like a big interface for a simple problem.
- Code doesn't match the kernel style (read Documentation/CodingStyle)
- Does it really need RCU and seqlock, wouldn't one suffice

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWIIVo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWIIVo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 17:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWIIVo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 17:44:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:15494 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751395AbWIIVo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:44:57 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 0/6] x86_64: Generic timekeeping for x86_64
Date: Sat, 9 Sep 2006 22:30:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060907021820.31476.17484.sendpatchset@localhost>
In-Reply-To: <20060907021820.31476.17484.sendpatchset@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609092230.49943.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 September 2006 04:18, john stultz wrote:
> Hey Andi,
> 	Just wanted to send this second pass on the x86_64 generic
> timekeeping conversion. It includes a number of changes you suggested,
> however its possible I missed a few things. I've made sure the patchset
> compiles at each stage, and atleast w/ the box I was using it booted
> each step as well.

Looks all reasonable from a quick look.
I assume it will clash with the recent patch to remove wall_jiffies use,
but that should be easy to fix.

How does the performance of the user space gettimeofday look
compared to the old code in TSC mode?

BTW I got some experimental code to put clock_gettime into
user space too, but that can be later merged I guess.

-Andi
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUF1O4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUF1O4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUF1Oy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:54:26 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:37393 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264997AbUF1OyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:54:05 -0400
Message-ID: <40E035CE.1020401@techsource.com>
Date: Mon, 28 Jun 2004 11:14:22 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Nice 19 process still gets some CPU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given how much I've read here about schedulers, I should probably be 
able to answer this question myself, but I just thought I might talk to 
the experts.

I'm running SETI@Home, and it has a nice value of 19.  Everything else, 
for the most part, is at zero.

I'm running kernel gentoo-dev-sources-2.6.7-r6 (I believe).

When I'm not running SETI@Home, compiler threads (emerge of a package, 
kernel compile, etc.) get 100% CPU.  When I AM running SETI@Home, 
SETI@Home still manages to get between 5% and 10% CPU.

I would expect that nice 0 processes should get SO MUCH more than nice 
19 processes that the nice 19 process would practically starve (and in 
the case of a nice 19 process, I think starvation by nice 0 processes is 
just fine), but it looks like it's not starving.

Why is that?

Thanks.


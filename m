Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVKMBer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVKMBer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKMBer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:34:47 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:42057 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750749AbVKMBer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:34:47 -0500
Message-ID: <43769834.7080804@bigpond.net.au>
Date: Sun, 13 Nov 2005 12:34:44 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] plugsched - update Kconfig-1
References: <434F01EA.6060709@bigpond.net.au> <200511111405.33762.kernel@kolivas.org> <200511111417.03859.kernel@kolivas.org>
In-Reply-To: <200511111417.03859.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 13 Nov 2005 01:34:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Here's a respin just changing the spa menu.
> 

While agreeing that PlugSched's configuration needs overhaul I don't 
think this is it as it just makes things more confusing.  I'll put 
fixing the configuration code on my list of things to do.  They main 
changes I see as necessary are:

1. Make the ability to select which schedulers are built in independent 
of EMBEDDED.
2. Only offer builtin schedulers as choice for the default scheduler.
3. Only build in ingosched if PLUGSCHED is not configured.

I'll try to get this change done next week.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWIWXZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWIWXZI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 19:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWIWXZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 19:25:08 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:40366 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1750913AbWIWXZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 19:25:07 -0400
X-IronPort-AV: i="4.09,208,1157342400"; 
   d="scan'208"; a="11949513:sNHT20133701"
Message-Id: <6.1.1.1.0.20060923191145.01eced00@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sat, 23 Sep 2006 19:25:24 -0400
To: David Woodhouse <dwmw2@infradead.org>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: linux-kernel@vger.kernel.org, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Thu, 2006-09-21 at 11:32 +0800, Luke Yang wrote:
> >   This is the blackfin architecture for 2.6.18, again.
>
>Please run 'make headers_check' for blackfin and then verify that you can 
>build libc against the resulting headers.

We can't build libc, but we can build uClibc ;)

This is how we build our toolchain today (mostly). - now we do a make 
prepare, but we will update it.

-Robin 

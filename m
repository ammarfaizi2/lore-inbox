Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317535AbSGOQdP>; Mon, 15 Jul 2002 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSGOQdO>; Mon, 15 Jul 2002 12:33:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36601 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317535AbSGOQdN>; Mon, 15 Jul 2002 12:33:13 -0400
Subject: Re: [PATCH] preemptive kernel for 2.4.19-rc1-ac3
From: Robert Love <rml@tech9.net>
To: tomlins@cam.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020715004355.65B462D12A@oscar.casa.dyndns.org>
References: <1026681042.939.9.camel@sinai> 
	<20020715004355.65B462D12A@oscar.casa.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 09:36:06 -0700
Message-Id: <1026750966.939.102.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 17:43, Ed Tomlinson wrote:

> If you build with preempt=N (for the scheduler stuff) the link of the 
> kernel fails.  

What, someone does not use preemption? 8)

An updated patch is available:

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-rc1-ac3-2.patch

I missed the definition of the new spin_unlock_no_resched from 2.5 in
the !CONFIG_PREEMPT case.  Thank you for pointing this out.

	Robert Love


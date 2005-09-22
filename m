Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVIVCTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVIVCTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVIVCTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:19:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43261 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750816AbVIVCTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:19:05 -0400
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
From: Daniel Walker <dwalker@mvista.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <433201FC.8040004@yahoo.com.au>
References: <1127345874.19506.43.camel@dhcp153.mvista.com>
	 <433201FC.8040004@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 19:18:57 -0700
Message-Id: <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-22 at 10:59 +1000, Nick Piggin wrote:

> You need my atomic_cmpxchg patches that provide an atomic_cmpxchg
> (and atomic_inc_not_zero) for all architectures.
> 

It is racy, but why not just disable preemption ..

Daniel


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUGJBFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUGJBFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbUGJBFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:05:37 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:15516 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266069AbUGJBF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:05:27 -0400
Date: Sat, 10 Jul 2004 02:04:29 +0100
From: Dave Jones <davej@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710010429.GB6386@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
References: <20040709182638.GA11310@elte.hu> <40EF3FAA.5000907@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EF3FAA.5000907@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 11:00:26AM +1000, Con Kolivas wrote:

 > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-bk20-H2
 > Looks nice.
 > 
 > I think you may have mixed up your trees. I think this change is the cfq 
 > bad allocation fix which I dont think is part of your voluntary 
 > preemption patch:
 > 
 > --- linux/drivers/block/cfq-iosched.c.orig	
 
It was this patch that found this bug 8-)  Without voluntary-preempt
it had been lying there unexposed for a while.  It's sort of must-have
if you use this patch, so I guess that's why Ingo rolled it in until
mainline gets the same fix.

		Dave


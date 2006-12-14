Return-Path: <linux-kernel-owner+w=401wt.eu-S1751490AbWLNKGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWLNKGb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWLNKGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:06:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:52154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751490AbWLNKGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:06:30 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19.1-rt14-smp circular locking dependency
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061214095926.GA19549@elte.hu>
References: <1166090243.7147.10.camel@Homer.simpson.net>
	 <20061214095926.GA19549@elte.hu>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 11:06:22 +0100
Message-Id: <1166090782.7147.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:59 +0100, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > Greetings,
> > 
> > Lockdep doesn't approve of cpufreq, and seemingly with cause... I had 
> > to poke SysRq-O.
> 
> hm ... this must be an upstream problem too, right? -rt shouldnt change 
> anything in this area (in theory).

I'll find out in a few.. enabling lockdep / compiling 2.5.19.1.

	-Mike


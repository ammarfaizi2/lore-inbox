Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUJQBcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUJQBcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 21:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268991AbUJQBcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 21:32:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41154 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268989AbUJQBcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 21:32:11 -0400
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, M <mru@mru.ath.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097963167.13226.4.camel@localhost.localdomain>
References: <41650CAF.1040901@unimail.com.au>
	 <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
	 <yw1x7jq2n6k3.fsf@mru.ath.cx>  <20041007143245.GA1698@openzaurus.ucw.cz>
	 <1097956343.2148.17.camel@krustophenia.net>
	 <1097963167.13226.4.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1097976283.2148.34.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 21:24:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 17:46, Alan Cox wrote:
> On Sad, 2004-10-16 at 20:52, Lee Revell wrote:
> > > What benefits? HZ=1000 takes 1W more on my system.
> > Better timer resolution?
> 
> And heavily reduced accuracy on a lot of laptops where 1000Hz
> is enough to make the clock slide every time the battery state is
> queried or an SMM event triggers.
> 

Wouldn't such a laptop be horribly broken?  1ms is a LONG time to
disable interrupts.  That's millions of CPU cycles...

> Getting the best of both worlds depends on the stuff discussed at OLS
> being finished, then you can have 1Khz accurancy and battery life
> 

I was not there but I imagine this involves a way to get 1khz accuracy
with a 100Hz timer interrupt rate?

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317956AbSGLAwi>; Thu, 11 Jul 2002 20:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317957AbSGLAwh>; Thu, 11 Jul 2002 20:52:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24059 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317956AbSGLAwh>; Thu, 11 Jul 2002 20:52:37 -0400
Subject: Re: HZ, preferably as small as possible
From: Robert Love <rml@tech9.net>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Stevie O <oliver@klozoff.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207111847440.30529-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0207111847440.30529-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Jul 2002 17:55:20 -0700
Message-Id: <1026435320.1178.362.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-11 at 17:50, Thunder from the hill wrote:

> On Thu, 11 Jul 2002, Stevie O wrote:
> > Why must HZ be the same as 'interrupts per second'?
> 
> s/interrupts/scheduler calls/

Uh, HZ is not scheduler calls per second.

Neither exactly is it interrupts per second, but _timer_ interrupts per
second.  It is the frequency of the timer interrupt.

> But what exactly does this question mean to be? I don't fully understand. 
> We define HZ to have an interval for the calls of the scheduler. That's 
> why it is the number of scheduler calls per second, because that's what it 
> was invented to be.

No no no...

	Robert Love


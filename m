Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUEYUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUEYUuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUEYUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:50:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28573 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265214AbUEYUuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:50:37 -0400
Subject: Re: System clock running too fast
From: john stultz <johnstul@us.ibm.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200405251939.47165.mbuesch@freenet.de>
References: <200405251939.47165.mbuesch@freenet.de>
Content-Type: text/plain
Message-Id: <1085518232.8653.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 May 2004 13:50:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 10:39, Michael Buesch wrote:
> I've got the problem with my server, that the system-clock
> is running really fast. It's running over one second too
> fast in one hour (aproximately).
> 
> The CPU of this machine is underclocked.
> It's a Pentium-1 133Mhz running at 75Mhz. All other hardware
> is running in its specifications. Can underclocking the CPU
> make the clock running faster? (I never saw a clock running
> slower on overclocked CPUs. 8-) )

Try setting up ntpd to correct for your system's drift (1sec/hour ~=
277ppm drift).

thanks
-john



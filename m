Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317414AbSGOKKs>; Mon, 15 Jul 2002 06:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSGOKKr>; Mon, 15 Jul 2002 06:10:47 -0400
Received: from mail.scs.ch ([212.254.229.5]:63669 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S317414AbSGOKKr>;
	Mon, 15 Jul 2002 06:10:47 -0400
Subject: Re: Linux 2.4.19-rc1-ac3
From: Thomas Sailer <sailer@scs.ch>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020713205422.E25995@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
	<m2n0svr42e.fsf@best.localdomain>
	<1026584861.13886.27.camel@irongate.swansea.linux.org.uk>
	<m265zj9zxn.fsf@best.localdomain> 
	<20020713205422.E25995@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 15 Jul 2002 12:13:40 +0200
Message-Id: <1026728020.2365.23.camel@watermelon.scs.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 21:54, Russell King wrote:

> You're right if your CPU usage is 100% - lowering the CPU clock rate
> means you take longer to complete the task, and with the static
> element of the CPU power consumption, you'd probably end up using
> more energy to perform the same task in a longer time.

The point is that frequency scaling is normally used with voltage
scaling. And lowering the voltage decreases the maximum frequency
roughly linearly, while the dynamic power consumption decreases
quadratically with voltage.

Tom


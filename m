Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSHQBHG>; Fri, 16 Aug 2002 21:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318960AbSHQBHG>; Fri, 16 Aug 2002 21:07:06 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2481 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318325AbSHQBHF>;
	Fri, 16 Aug 2002 21:07:05 -0400
Subject: Re: [RFC] linux-2.4.31_timer-change_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1029545206.966.269.camel@cog>
References: <1029545206.966.269.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Aug 2002 17:56:17 -0700
Message-Id: <1029545778.966.272.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 17:46, john stultz wrote:
> Right now I've just taken the existing code put all TSC releated code
> into one file, all PIT related code into another, and created struct
> timer_ops that provides a generic interface. I've avoided making any
> changes to the actual code, so its as transparent a change as possible.
> I plan further cleanups to better separate the pit/tsc hardware
> initialization from the pit/tsc timer initialization, as well as
> properly moving the credits to be with their now-long-lost code.  

Oh yes, credits to Alan for suggesting it all get wrapped up w/
timer_ops.

-john



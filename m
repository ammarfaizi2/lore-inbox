Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbTAUXrt>; Tue, 21 Jan 2003 18:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTAUXrr>; Tue, 21 Jan 2003 18:47:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61074 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267351AbTAUXro>;
	Tue, 21 Jan 2003 18:47:44 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030121234835.GA22132@wotan.suse.de>
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p731y36m6d0.fsf@oldwotan.suse.de>
	 <1043191868.15688.93.camel@w-jstultz2.beaverton.ibm.com>
	 <20030121234835.GA22132@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1043192965.15688.105.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 21 Jan 2003 15:49:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 15:48, Andi Kleen wrote:
> On Tue, Jan 21, 2003 at 03:31:08PM -0800, john stultz wrote:
> > > what happens when 1000000 does not evenly divide HZ? 
> > > I think some ports use HZ=1024
> > 
> > Then it comes out to close enough? I'm probably just not getting the
> > problem. Could you further explain?
> 
> Have you checked it that it yields an usable value? I'm just asking 
> because I've been badly burned by such integer rounding issues in the 
> past, so it is better to double check them...

Ok, fair enough. I'll double check that. 

thanks
-john



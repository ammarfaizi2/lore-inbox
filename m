Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTAUXj3>; Tue, 21 Jan 2003 18:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbTAUXj3>; Tue, 21 Jan 2003 18:39:29 -0500
Received: from ns.suse.de ([213.95.15.193]:50698 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267338AbTAUXj2>;
	Tue, 21 Jan 2003 18:39:28 -0500
Date: Wed, 22 Jan 2003 00:48:35 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
Message-ID: <20030121234835.GA22132@wotan.suse.de>
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel> <p731y36m6d0.fsf@oldwotan.suse.de> <1043191868.15688.93.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043191868.15688.93.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 03:31:08PM -0800, john stultz wrote:
> > what happens when 1000000 does not evenly divide HZ? 
> > I think some ports use HZ=1024
> 
> Then it comes out to close enough? I'm probably just not getting the
> problem. Could you further explain?

Have you checked it that it yields an usable value? I'm just asking 
because I've been badly burned by such integer rounding issues in the 
past, so it is better to double check them...

-Andi


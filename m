Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSH0Tvx>; Tue, 27 Aug 2002 15:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSH0Tvx>; Tue, 27 Aug 2002 15:51:53 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:42138 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316182AbSH0Tvw>;
	Tue, 27 Aug 2002 15:51:52 -0400
Date: Tue, 27 Aug 2002 13:54:01 -0600
From: yodaiken@fsmlabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
Message-ID: <20020827135400.A31990@hq.fsmlabs.com>
References: <3D6BB9E2.DE71FE2C@compro.net> <Pine.LNX.3.95.1020827135107.10631A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020827135107.10631A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Aug 27, 2002 at 02:01:43PM -0400
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 02:01:43PM -0400, Richard B. Johnson wrote:
> This cannot be. A stock kernel-2.4.18, running a 133 MHz AMD-SC520,
> (like a i586) with a 33 MHz bus, handles interrupts off IRQ7 (the lowest
> priority), from the 'printer port' at well over 75,000 per second without
> skipping a beat or missing an edge. This means that latency is at least
> as good as 1/57,000 sec = 0.013 microseconds.

Assuming you mean 75,000 then ... 
Thats 0.013 MILLISECONDS which is 13 microseconds and its not likely.
I bet that your data source drops data or looks at some handshake
pins on the parallel connect.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com


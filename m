Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbTBJNsi>; Mon, 10 Feb 2003 08:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTBJNsi>; Mon, 10 Feb 2003 08:48:38 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:39859 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267852AbTBJNsh>; Mon, 10 Feb 2003 08:48:37 -0500
Date: Mon, 10 Feb 2003 14:58:22 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: SA <no_spam@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt latency ?
Message-ID: <20030210135822.GA14827@wohnheim.fh-wedel.de>
References: <200302071850.52781.no_spam@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302071850.52781.no_spam@ntlworld.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 February 2003 18:50:52 +0000, SA wrote:
> 
> What latency should I expect for hardware interrupts under k2.4 / i386 ? 
> 
> 
> ie how long should it take between the hardware signalling the interrupt and 
> the interrupt handler being called?

Upper limit should be ~10,000 clock cycles.
Doing some tests on ppc, some rtos was able to react within 200
cycles, linux took 1000 or so. Add whatever time you handler (the c
code) takes.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon

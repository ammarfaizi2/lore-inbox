Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268583AbRGYQgo>; Wed, 25 Jul 2001 12:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268584AbRGYQge>; Wed, 25 Jul 2001 12:36:34 -0400
Received: from [209.250.53.219] ([209.250.53.219]:52996 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S268583AbRGYQgZ>; Wed, 25 Jul 2001 12:36:25 -0400
Date: Wed, 25 Jul 2001 11:34:45 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why no modules for IDE chipset support?
Message-ID: <20010725113445.B25434@hapablap.dyn.dhs.org>
In-Reply-To: <15198.37357.879359.519563@hertz.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15198.37357.879359.519563@hertz.ikp.physik.tu-darmstadt.de>; from bon@elektron.ikp.physik.tu-darmstadt.de on Wed, Jul 25, 2001 at 11:31:25AM +0200
X-Uptime: 11:01am  up 11:03,  0 users,  load average: 1.00, 1.01, 1.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25, 2001 at 11:31:25AM +0200, Uwe Bonnes wrote:
> Hallo,
> 
> why are the IDE chipset support driver not modularized? Is there anything
> fundamental that inhibits using these drivers as a modules?

They are availible as modules.  See "ATA/IDE/MFM/RLL support," which is
a tristate.  If you select that as a module, then all the chipsets you
select for support later will be compiled into one large module.

This is probably a bad idea, though, because if you compile IDE support
as a module, you will not be able to mount your root partition if it is
on an IDE disk.

I hope this clears things up for you.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

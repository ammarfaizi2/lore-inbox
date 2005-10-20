Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVJTPe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVJTPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVJTPe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:34:27 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:49296 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932192AbVJTPe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:34:26 -0400
Message-ID: <20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
Date: Thu, 20 Oct 2005 16:34:25 +0100
From: Chris Boot <bootc@bootc.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
References: <43567D80.3050304@bootc.net> <20051020131815.GI2811@suse.de>
In-Reply-To: <20051020131815.GI2811@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jens Axboe <axboe@suse.de>:

> On Wed, Oct 19 2005, Chris Boot wrote:
>> I don't get any OOPSes or BUGs or anything, not on my screen nor on my
>> serial console (although I'm not sure I have this working right--I only
>> seem to get kernel boot messages). Machine replies to pings but I can't
>
> Easy fix for that is probably to kill klogd on the machine. Test with eg
> loading/unloading of loop, that prints a message when it loads.

I'd love to, but the machine is locked solid and won't turn on the display or
switch TTYs or anything. Anyway, I've applied reiser4-fix-livelock.patch from
ftp.namesys.org and so far so good (over night).

I see there's now a reiser4-fix-livelock-2.patch, anybody know the 
differences?

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

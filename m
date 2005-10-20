Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVJTQUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVJTQUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVJTQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:20:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19735 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932425AbVJTQUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:20:22 -0400
Date: Thu, 20 Oct 2005 18:21:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
Message-ID: <20051020162112.GT2811@suse.de>
References: <43567D80.3050304@bootc.net> <20051020131815.GI2811@suse.de> <20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20 2005, Chris Boot wrote:
> Quoting Jens Axboe <axboe@suse.de>:
> 
> >On Wed, Oct 19 2005, Chris Boot wrote:
> >>I don't get any OOPSes or BUGs or anything, not on my screen nor on my
> >>serial console (although I'm not sure I have this working right--I only
> >>seem to get kernel boot messages). Machine replies to pings but I can't
> >
> >Easy fix for that is probably to kill klogd on the machine. Test with eg
> >loading/unloading of loop, that prints a message when it loads.
> 
> I'd love to, but the machine is locked solid and won't turn on the
> display or switch TTYs or anything. Anyway, I've applied
> reiser4-fix-livelock.patch from ftp.namesys.org and so far so good
> (over night).

I mean _before_ the crash, to make sure the messages get out :-)

-- 
Jens Axboe


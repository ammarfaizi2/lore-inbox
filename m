Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUAYFbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 00:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUAYFbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 00:31:08 -0500
Received: from colo.lackof.org ([198.49.126.79]:22247 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S263646AbUAYFbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 00:31:03 -0500
Date: Sat, 24 Jan 2004 22:31:01 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
Message-ID: <20040125053101.GA19244@colo.lackof.org>
References: <20040124013614.GB1310@colo.lackof.org> <20040123.210023.74723544.davem@redhat.com> <20040124073032.GA7265@colo.lackof.org> <20040123.233241.59493446.davem@redhat.com> <4012E071.2080704@pobox.com> <20040125014859.GD16272@colo.lackof.org> <40132199.9090200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40132199.9090200@pobox.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 08:53:29PM -0500, Jeff Garzik wrote:
> Hey, feel free to address as many issues as you would like!  :)

:^)

I'll try to keep it at "One at a Time".
I muddy the waters enough as it is.


> >BTW, next on the horizon is removing FTQ reset.
> >I'm told the FTQ reset is NOT performed by the Tru64 (Alpha/Unix) driver
> >and Broadcom is testing that with the next release of bcm5700 now.
> 
> We just went through this with Broadcom, when David applied fixes 
> related to ASF...  rather than what Broadcom is _testing_, though, I'm 
> more interested to know if GRC resets FTQ's according to the hardware 
> engineers?

email from "Wed Jan 21" says:
"FTQ stands for Flow Through Queue and they are used to connect different
state machines. It turns out that it should also be unnecessary to reset
the FTQs as they get reset during GRC reset. While the FTQ reset itself
is harmless, we recently discovered that it created a race condition
with ASF firmware...."

I don't know more than that. "should also" probably isn't as
conclusive as you would like and it's now third hand.
But you probably know who to ask at Broadcom...

hth,
grant

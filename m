Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUAYBtG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUAYBtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:49:06 -0500
Received: from colo.lackof.org ([198.49.126.79]:44261 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S263587AbUAYBtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:49:00 -0500
Date: Sat, 24 Jan 2004 18:48:59 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, grundler@parisc-linux.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
Message-ID: <20040125014859.GD16272@colo.lackof.org>
References: <20040124013614.GB1310@colo.lackof.org> <20040123.210023.74723544.davem@redhat.com> <20040124073032.GA7265@colo.lackof.org> <20040123.233241.59493446.davem@redhat.com> <4012E071.2080704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4012E071.2080704@pobox.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 04:15:29PM -0500, Jeff Garzik wrote:
> David,
> 
> There were two separate components to Grant's patch (hint ggg... split 
> up your patches).

you are right - sorry.
I'll break it down when I submit patches for RHEL3/ia64.
(Actually, I'll only submit the changes david accepted).

I had already rejected some other issues broadcom wanted me to address.


> What do you think about GRC-resets-sub-components part?
> That appears valid (and probably wise) to me, but correct me if I'm wrong...

BTW, next on the horizon is removing FTQ reset.
I'm told the FTQ reset is NOT performed by the Tru64 (Alpha/Unix) driver
and Broadcom is testing that with the next release of bcm5700 now.

thanks,
grant

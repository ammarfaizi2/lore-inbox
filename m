Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264993AbSJPOeO>; Wed, 16 Oct 2002 10:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265007AbSJPOeO>; Wed, 16 Oct 2002 10:34:14 -0400
Received: from dp.samba.org ([66.70.73.150]:58246 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264993AbSJPOeO>;
	Wed, 16 Oct 2002 10:34:14 -0400
Date: Thu, 17 Oct 2002 00:38:22 +1000
From: Anton Blanchard <anton@samba.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021016143822.GA4320@krispykreme>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAD75AE.7010405@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AFAIK Linus and Al Viro (and myself <g>) have always considered ioctls 
> an ugly -ism that should have never made it into Unix.  Over and above 
> the Unix/VFS design problems with ioctl(2), ioctl(2) is a pain for 
> people like David Miller who must maintain 32<->64 bit ioctl translation 
> layers for their architecture.  ia64 and x64-64 must do this too.  Each 
> ioctl you add is an additional headache for them.

And ppc64 :) Lately Dave, Andi and I seem to be spending too much time
bouncing fixes around for 32/64 bit ioctl and syscall translation code.

Anton

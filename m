Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSJRAm7>; Thu, 17 Oct 2002 20:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSJRAm7>; Thu, 17 Oct 2002 20:42:59 -0400
Received: from zero.aec.at ([193.170.194.10]:3087 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262397AbSJRAm7>;
	Thu, 17 Oct 2002 20:42:59 -0400
Date: Fri, 18 Oct 2002 02:48:45 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@muc.de>, Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021018004844.GA14275@averell>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk> <3DAD8CC9.9020302@pobox.com> <20021017080552.GA2418@fib011235813.fsnet.co.uk> <m3fzv5pj23.fsf@averell.firstfloor.org> <3DAED2DB.3030407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAED2DB.3030407@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ioctls are analogous to procfs:  they are simple, easy, and usually the 
> wrong thing to do.

Simple truths. Like always you need to add your common sense though.

I just contend that it's not always the right thing to try to clamp
what's a simple ioctl into a complicated file system. From Joe's description
of the fs interface it sounds to me like the ioctls are a lot simpler
than the fs based version. KISS principle applies.

-Andi

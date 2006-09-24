Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWIXSOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWIXSOn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWIXSOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:14:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:59344 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751334AbWIXSOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:14:42 -0400
X-Authenticated: #14349625
Subject: Re: sluggish system responsiveness under higher IO load
From: Mike Galbraith <efault@gmx.de>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <200609241632.11126.mlkernel@mortal-soul.de>
References: <200608061200.37701.mlkernel@mortal-soul.de>
	 <200609031315.04308.mlkernel@mortal-soul.de>
	 <20060915181709.GA15333@kernel.dk>
	 <200609241632.11126.mlkernel@mortal-soul.de>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 20:27:17 +0000
Message-Id: <1159129637.6098.60.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 16:32 +0200, Matthias Dahl wrote:
> On Friday 15 September 2006 20:17, Jens Axboe wrote:
> 
> > Sounds like a hardware issue, someone could be hogging the bus. You
> > could try and play with the pci latency setting.
> 
> Is there a way I can debug this...? I really would like to get to the bottom 
> of this somehow. I did one more test: installed and started enemy territory 
> because it's free and heavily uses OpenGL... works fine so far. But simply 
> starting an untar process in the background while et is running causes quite 
> distorted sound and even the mouse pointer won't react in time anymore until 
> the untar process is finished. This can't be right. IO load shouldn't cause 
> sluggish responsiveness...

It depends a lot on how the application is written.  Start your app at
nice -10, and retry the IO interference test.

	-Mike


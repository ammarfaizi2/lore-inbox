Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291637AbSBAJ1y>; Fri, 1 Feb 2002 04:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291636AbSBAJ1f>; Fri, 1 Feb 2002 04:27:35 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:46228 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291634AbSBAJ1a>; Fri, 1 Feb 2002 04:27:30 -0500
Message-Id: <200202010927.g119RPWL007955@tigger.cs.uni-dortmund.de>
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB - take 2 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Thu, 31 Jan 2002 12:49:43 GMT." <20020131124942.A37@toy.ucw.cz> 
Date: Fri, 01 Feb 2002 10:27:25 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> said:

[...]

> > -	iobus_register(&b->iobus);
> > +	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
> Uff...				~~~~~~~~~ would not "struct device" (or
> what should it be) look better?

Yep, but there is _no_ chance to screw up ("or what should it be" ;-) this
way.
-- 
Horst von Brand			     http://counter.li.org # 22616

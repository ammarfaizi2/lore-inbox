Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290832AbSARVVb>; Fri, 18 Jan 2002 16:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290831AbSARVVV>; Fri, 18 Jan 2002 16:21:21 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:17303 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290824AbSARVVL>; Fri, 18 Jan 2002 16:21:11 -0500
Message-Id: <200201182120.g0ILKZWH004851@tigger.cs.uni-dortmund.de>
To: Matt Bernstein <matt@theBachChoir.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: probably very irrelevant oops 
In-Reply-To: Message from Matt Bernstein <matt@theBachChoir.org.uk> 
   of "Fri, 18 Jan 2002 16:22:03 GMT." <Pine.LNX.4.44.0201181559540.2851-100000@nick.dcs.qmul.ac.uk> 
Date: Fri, 18 Jan 2002 22:20:35 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein <matt@theBachChoir.org.uk> said:
> >The bug probably is in the module which immediately preceded
> >es1371 in your /proc/modules output.  Could you please load
> >them all up again, send me your /proc/modules output?
> 
> Further exploration revealed an oops on loading the modules. Here's a clip
> from find /lib/modules/2.4.17-expt/kernel -type f

Could you try just loading that last module (and anything it might depend
on)? I looks like a problem with the module expecting some parameter it
doesn't get, and then screwing up. [Just a random guess].
-- 
Horst von Brand			     http://counter.li.org # 22616

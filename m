Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRCHUR6>; Thu, 8 Mar 2001 15:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRCHURu>; Thu, 8 Mar 2001 15:17:50 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:25096 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129657AbRCHURd>;
	Thu, 8 Mar 2001 15:17:33 -0500
Message-Id: <200103082128.QAA03538@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Paul Larson" <plars@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel stress testing coverage 
In-Reply-To: Your message of "Thu, 08 Mar 2001 13:52:21 CST."
             <OF6900214E.F6A2F64E-ON85256A09.006A7125@raleigh.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Mar 2001 16:28:24 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plars@us.ibm.com said:
>  I've heard of tools like gcov for doing this with applications, but
> the kernel itself seems like it might require something more.

Have a look at user-mode Linux (http://user-mode-linux.sourceforge.net).  It 
runs the kernel in userspace, so gprof and gcov can be used on it (although, 
at the moment, neither work on UML because of architectural changes I've made 
since I first made them work - these problems will be fixed in the 
medium-term).

Both gprof and gcov produce very interesting information when run on the 
kernel.

So, while you're gathering up tools and information, gather up UML and start 
playing with it.  And if you feel like it, make gcov work again on it - I 
accept patches :-)
				Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSIWH0Y>; Mon, 23 Sep 2002 03:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265023AbSIWH0Y>; Mon, 23 Sep 2002 03:26:24 -0400
Received: from dp.samba.org ([66.70.73.150]:5508 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265002AbSIWH0X>;
	Mon, 23 Sep 2002 03:26:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Representing System devices and CPUs 
In-reply-to: Your message of "Wed, 18 Sep 2002 13:40:05 MST."
             <Pine.LNX.4.44.0209181311240.968-200000@cherise.pdx.osdl.net> 
Date: Mon, 23 Sep 2002 16:33:30 +1000
Message-Id: <20020923073133.E86E82C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209181311240.968-200000@cherise.pdx.osdl.net> you wr
ite:
> For ia32, I've created a simple CPU device driver and a static array of 
> cpu devices of size NR_CPUS, which are manually registered on boot. The 
> cpus get directories under root/sys/ in driverfs, like this:

Hi Patrick!

	Thanks for your work and sorry for the slow response.  This
seems good, except if (!cpu_possible(i)) don't create the directory.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

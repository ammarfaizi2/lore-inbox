Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSGQUGY>; Wed, 17 Jul 2002 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSGQUGY>; Wed, 17 Jul 2002 16:06:24 -0400
Received: from [209.184.141.189] ([209.184.141.189]:18458 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S316615AbSGQUGX>;
	Wed, 17 Jul 2002 16:06:23 -0400
Subject: [RFC] Groups beyond 32
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 17 Jul 2002 15:09:16 -0500
Message-Id: <1026936556.25347.48.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When changing the kernel to handle groups beyond 32, and of course the
glibc as well, I noticed that I could no longer SSH out of the box. 

The problem with this is not huge, ask a few questions, some more
recompiling and then ssh will start working. Fine.

The problem now is more one of maintenance. Most distributions do not
support groups > 32 AFAIK. So, it's lead me to ask the following
questions:

1. Why, in general, is the limit so low? 
   For specific application, mainly auditing and such, this would be    
   advantageous I think.

2. What is required to limit the dependence on groups to just GLIBC or
just the kernel? Is that even possible?

3. Is there any true advantage to supporting more than 32 groups, or
creating "meta-groups" to get around the problem? 


The main reason I ask, is because just like the unknown with ssh not
supporting > 32 groups without modification, there can be others. Plus
with most distros, using automated upgrades via push, or some such
mechanism is encumbered by customizations to glibc, ssh, and potentially
other packages. 


-- 
Austin Gonyou <austin@digitalroadkill.net>

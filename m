Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTAJJCd>; Fri, 10 Jan 2003 04:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAJJBc>; Fri, 10 Jan 2003 04:01:32 -0500
Received: from dp.samba.org ([66.70.73.150]:41118 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264683AbTAJJB3>;
	Fri, 10 Jan 2003 04:01:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Michael Hunold <m.hunold@gmx.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [BUG][2.5] System crash with PCI drivers that handle the same devices 
In-reply-to: Your message of "Wed, 08 Jan 2003 18:23:18 BST."
             <3E1C5E86.9050700@gmx.de> 
Date: Fri, 10 Jan 2003 19:23:00 +1100
Message-Id: <20030110091013.42E1F2C407@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E1C5E86.9050700@gmx.de> you write:
> Hello Rusty and others,

I'm not sure why I'm in here...

Have you tried doung both these builtin?

Your drivers also have the same name, which is odd, at least.  Also,
you should use SET_MODULE_OWNER or set .owner = THIS_MODULE.

Jeff prefers SET_MODULE_OWNER, but I never figured out why.

Sorry I can't be of more help,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

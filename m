Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSKNRBi>; Thu, 14 Nov 2002 12:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSKNRBX>; Thu, 14 Nov 2002 12:01:23 -0500
Received: from dp.samba.org ([66.70.73.150]:38341 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265033AbSKNQ75>;
	Thu, 14 Nov 2002 11:59:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools breaks kallsyms 
In-reply-to: Your message of "Thu, 14 Nov 2002 05:35:53 CDT."
             <200211141035.gAEAZt2t017446@pool-151-204-203-202.delv.east.verizon.net> 
Date: Fri, 15 Nov 2002 04:51:19 +1100
Message-Id: <20021114170651.9F6732C2E0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211141035.gAEAZt2t017446@pool-151-204-203-202.delv.east.verizon.
net> you write:
> Install of module-init-tools moves the old tools to *.old but it doesn't
> address kallsyms.  In the case of kallsyms being a link to insmod, it
> breaks.  Since the new insmod is supposed to call insmod.old when
> appropriate, I'm not sure why it breaks.  But it doesn't work here.

symlink, and yes you're right.  Which is a PITA.  The patch floating
around which moves the module-init-tools inside the modutils source
fixes this plainly, once and for all (you just install the "new"
modutils).

I still haven't slept.  But after I do, I'll fix this, I promise.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

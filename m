Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUAVHQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUAVHQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:16:25 -0500
Received: from dp.samba.org ([66.70.73.150]:19350 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264420AbUAVHQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:16:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Tue, 20 Jan 2004 23:08:44 -0800."
             <20040121070844.GA31807@hockin.org> 
Date: Thu, 22 Jan 2004 16:29:39 +1100
Message-Id: <20040122071637.6C38D2C0F8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040121070844.GA31807@hockin.org> you write:
> Process A has now discarded useful potentially VALUABLE information, with no
> way to retrieve it.  The hot plug scripts do not have enough information to
> put things the way they were before.  I can't believe that anyone considers
> this to be OK.

We already established that the process which cares has to listed to
hotplug events.

Userland should handle it *before* telling the kernel to remove the
CPU.  What we're dealing with here is merely a corner case, IMHO worth
neither hysteria nor a great deal of code.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

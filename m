Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUACDIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 22:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbUACDIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 22:08:14 -0500
Received: from dp.samba.org ([66.70.73.150]:11722 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265886AbUACDIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 22:08:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Fri, 02 Jan 2004 08:58:09 -0800."
             <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> 
Date: Sat, 03 Jan 2004 14:05:40 +1100
Message-Id: <20040103030802.BD1DB2C06E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> you write:
> Rusty, you still have to use global static data when there is no need.

And you're still putting obscure crap in the task struct when there's
no need.  Honestly, I'd be ashamed to post such a patch.

> I like this version better though ;)

I think I should seek a second opinion though.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

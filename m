Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265924AbUBCI21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbUBCI21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:28:27 -0500
Received: from dp.samba.org ([66.70.73.150]:57835 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265924AbUBCI20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:28:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-reply-to: Your message of "Tue, 03 Feb 2004 09:04:36 BST."
             <20040203080436.GA374@elte.hu> 
Date: Tue, 03 Feb 2004 19:16:27 +1100
Message-Id: <20040203082839.DA05B2C0AB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040203080436.GA374@elte.hu> you write:
> 
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > This terminating signal idea is simply flawed: affinity is inherited,
> > so you're killing a process which knows nothing anyway.
> > 
> > If we can't do it well, leave it to userspace to sort out 8)
> 
> yes, but currently there's no mechanism for userspace to get notified -
> hence no clean way for userspace to sort it out. (other than userspace
> continuously polling the CPU mask - bleh.) But this is a separate issue.

We use /sbin/hotplug at the moment.  I'm hoping that DBUS turn this
from "possible" into "easy" some day...

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

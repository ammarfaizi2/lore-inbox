Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUAUIOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUAUIOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:14:16 -0500
Received: from dp.samba.org ([66.70.73.150]:64444 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265285AbUAUIOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:14:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
Cc: Tim Hockin <thockin@hockin.org>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
In-reply-to: Your message of "Wed, 21 Jan 2004 15:14:03 +1100."
             <400DFC8B.7020906@cyberone.com.au> 
Date: Wed, 21 Jan 2004 19:11:31 +1100
Message-Id: <20040121081430.004AA2C10D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <400DFC8B.7020906@cyberone.com.au> you write:
> Or doesn't anybody care to think about hoplug scripts failing?
> (serious question)

It seems not.  I don't neccessarily agree with it, but we'll see how
it goes.

Guarantees are hard: if the script is supposed to fork something and
you're out of memory, what do you do?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

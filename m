Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUAUFJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 00:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUAUFJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 00:09:18 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:62087 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265948AbUAUFJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 00:09:15 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: vatsa@in.ibm.com
Cc: Nick Piggin <piggin@cyberone.com.au>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Wed, 21 Jan 2004 09:36:33 +0530."
             <20040121093633.A3169@in.ibm.com> 
Date: Wed, 21 Jan 2004 16:07:06 +1100
Message-Id: <20040121050853.AF2F217DDE@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040121093633.A3169@in.ibm.com> you write:
> On Tue, Jan 20, 2004 at 12:43:52AM -0800, Tim Hockin wrote:
> > IFF the app is designed to handle it.  The existence of a SIGPWR handler
> > does not necessarily imply that, though.  a SIGCPU or something might
> > correlate 1:1 with this, but SIGPWR doesn't.
> 
> I agree we should have a separe signal for CPU Hotplug.

Can we add signals without breaking userspace?

If we can, SIGRECONFIG makes sense.  If not, I'd rather not have a
signal, rely on hotplug, and look at addding a signal in 2.7.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUBUBIC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUBUBIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:08:02 -0500
Received: from dp.samba.org ([66.70.73.150]:17347 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261460AbUBUBH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:07:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Booting when CPUs fail to come up. 
In-reply-to: Your message of "Fri, 20 Feb 2004 17:10:42 BST."
             <20040220161042.GI23278@elf.ucw.cz> 
Date: Sat, 21 Feb 2004 11:37:02 +1100
Message-Id: <20040221010811.2D3112C3A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040220161042.GI23278@elf.ucw.cz> you write:
> Hi!
> 
> > I recently played with setting a bit in cpu_possible_map that wasn't
> > in cpu_online_map: this can happen without hotplug CPU when a CPU
> > fails to boot, for example.
> 
> Is it safe to continue when one cpu is apparently malfunctioning?

Well, patch was overzealous and no longer required.

But we shouldn't crash when this happens just because a CPU didn't
come up.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTKODZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 22:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTKODZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 22:25:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:58584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261332AbTKODZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 22:25:53 -0500
Date: Fri, 14 Nov 2003 19:25:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <Pine.LNX.4.44.0311141906160.9014-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311141923260.9014-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Nov 2003, Linus Torvalds wrote:
> 
> Why? Check out get_signal_to_deliver(). And grok the absolute horridness.

Btw, don't get me wrong - I'm not proud about it. I only noticed how
horrid it was of x86 to depend on this behaviour in do_signal() about a
week ago, and since it's not a bug I'm not fixing it for 2.6.0.

It may not be pretty, but it works.

		Linus


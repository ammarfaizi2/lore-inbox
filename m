Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272464AbTHKJDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272485AbTHKJDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:03:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34008 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S272464AbTHKJCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:02:11 -0400
Date: Mon, 11 Aug 2003 11:00:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
In-Reply-To: <3F361F5E.10106@colorfullife.com>
Message-ID: <Pine.LNX.4.56.0308111059360.21165@localhost.localdomain>
References: <3F361F5E.10106@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Aug 2003, Manfred Spraul wrote:

> The functions in mm/usercopy assume that no exception handling is
> required if fs is KERNEL_DS. This is not true: at least the mount
> options copy and the i386 traps handler assume exception handling with
> fs==KERNEL_DS.

hm, what do you mean by the i386 traps handler? The boot-time WP detection
fault thing?

	Ingo

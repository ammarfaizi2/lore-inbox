Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTHNQTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTHNQTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:19:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:59083 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270479AbTHNQTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:19:32 -0400
Date: Thu, 14 Aug 2003 09:19:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
In-Reply-To: <20030814130810.A332@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Aug 2003, Russell King wrote:
> 
> After reviewing the /proc/kcore and kclist issues, I've decided that I'm
> no longer prepared to even _think_ about supporting /proc/kcore on ARM -

I suspect we should just remove it altogether.

Does anybody actually _use_ /proc/kcore? It was one of those "cool 
feature" things, but I certainly haven't ever used it myself except for 
testing, and it's historically often been broken after various kernel 
infrastructure updates, and people haven't complained..

Comments?

		Linus


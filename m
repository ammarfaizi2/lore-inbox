Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbTIKOBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTIKOBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:01:18 -0400
Received: from ns.suse.de ([195.135.220.2]:60304 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261310AbTIKOBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:01:17 -0400
Date: Thu, 11 Sep 2003 16:01:08 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911160108.5678113b.ak@suse.de>
In-Reply-To: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
References: <20030911012708.GD3134@wotan.suse.de>
	<Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 06:54:53 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> This patch is fragile and looks pointless.

Why do you think it is fragile?  I don't see anything fragile in it.

> 
> What's wrong with the current status quo that just says "Athlon prefetch
> is broken"?

It doesn't fix user space for once.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbTHVRgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTHVRgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:36:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:40096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263174AbTHVRgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:36:02 -0400
Date: Fri, 22 Aug 2003 10:35:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
In-Reply-To: <20030822170523.GA7819@lst.de>
Message-ID: <Pine.LNX.4.44.0308221027070.20736-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Aug 2003, Christoph Hellwig wrote:
> 
> What about two new options to replace the old CONFIG_EMBEDDED?

If it's just a naming issue for you, then yes, we could change the current 
EXPERIMENTAL/BROKEN/EMBEDDED questions around a bit.

So we could split the EMBEDDED question into "STANDARD" (which implies VT,
INPUT layer, PS/2 ATKBD) and "FEATURECOMPLETE" (FUTEX, EPOLL, NET).

Is it worth it? I see EMBEDDED as more of a "STANDARD" thing - for people
who don't care or know, that's a slight safety-net saying "this selects
the things you take for grated".

		Linus


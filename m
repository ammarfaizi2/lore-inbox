Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTHVQuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTHVQuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:50:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:34949 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263178AbTHVQuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:50:12 -0400
Date: Fri, 22 Aug 2003 09:50:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
In-Reply-To: <20030822163800.GA7568@lst.de>
Message-ID: <Pine.LNX.4.44.0308220947010.3258-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Aug 2003, Christoph Hellwig wrote:
>
> There's really no point in forcing in support for all kinds of
> optional input devices unless CONFIG_EMBEDDED.

I disagree. We've had too many totally unnecessary bug-reports from 
people, and it's just not worth it not having the keyboard and mouse 
controller driver.

However, we can certainly improve on it, and the "select INPUT if VT" part 
makes fine sense.

		Linus


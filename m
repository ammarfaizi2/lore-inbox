Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTIGXPk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTIGXPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 19:15:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:24540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261705AbTIGXPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 19:15:40 -0400
Date: Sun, 7 Sep 2003 16:15:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andreas Schwab <schwab@suse.de>, <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
In-Reply-To: <200309072128.h87LScJZ009118@post.webmailer.de>
Message-ID: <Pine.LNX.4.44.0309071613560.21192-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Sep 2003, Arnd Bergmann wrote:
> 
> How about changing (sizeof(x)) to (sizeof(x[1]))?
> It will result in "parse error before `['" when x is not
> a type or an array type.

That sounds like a clever thing to do. Have you tested it with a full 
configuration?

		Linus


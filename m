Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUASXl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUASXl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:41:58 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:16310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264434AbUASXl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:41:56 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20040119204005.GA380@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <20040119204005.GA380@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074555607.12225.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 10:40:08 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You need to check resulting assembly for stack accesses. So yes, you
> can compile it from .c file, _but you have to read it_.

Hrm... That's awful and terribly fragile. You should either write
it entirely in assembly (thus readable & commented) or write it in
C with a temporary stack or whatever that makes it safe. I'll certainly
not let something like that sneak into arch/ppc anyway.

Ben.



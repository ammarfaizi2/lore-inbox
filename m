Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUASWth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUASWth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:49:37 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:11137 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263625AbUASWtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:49:36 -0500
Date: Mon, 19 Jan 2004 21:40:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040119204005.GA380@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074489645.2111.8.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I can answer a couple of the questions:
> 
> > What is this file ? It's absolutely horrible....
> 
> It should contain the .S equivalent to the swsusp2.c file. It would be
> best if swsusp2.c could simply be compiled, but it appears that it can't
> at the moment on x86 (I need to learn x86 assembly so I can understand
> why).

You need to check resulting assembly for stack accesses. So yes, you
can compile it from .c file, _but you have to read it_.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

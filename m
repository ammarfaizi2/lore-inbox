Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUATC2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUATAH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:07:56 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:62082 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263260AbUASX7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:32 -0500
Date: Tue, 20 Jan 2004 00:59:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040119235907.GA837@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <20040119204005.GA380@elf.ucw.cz> <1074555607.12225.91.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074555607.12225.91.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You need to check resulting assembly for stack accesses. So yes, you
> > can compile it from .c file, _but you have to read it_.
> 
> Hrm... That's awful and terribly fragile. You should either write
> it entirely in assembly (thus readable & commented) or write it in

Take a look before commenting.

Long time ago I took .c version, compiled it into assembly,
handcleaned (etc) and now its used.

But if someone wants to do ppc, taking .c version, compiling it into
assembly, then checking/fixing is probably easiest way...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

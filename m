Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTIBGmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTIBGmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:42:16 -0400
Received: from dp.samba.org ([66.70.73.150]:53977 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263573AbTIBGmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:42:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petri Koistinen <petri.koistinen@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] include/asm-i386/module.h defined() fix 
In-reply-to: Your message of "Sat, 30 Aug 2003 17:42:45 +0300."
             <Pine.LNX.4.56.0308301717480.18600@dsl-hkigw4a35.dial.inet.fi> 
Date: Tue, 02 Sep 2003 15:14:50 +1000
Message-Id: <20030902064215.CC6092C14D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.56.0308301717480.18600@dsl-hkigw4a35.dial.inet.fi> you w
rite:
> Hi!
> 
> Take a look at The C Programming Language (2nd ed.) page 91. "The
> expression defined(name) in a #if is 1 if the name has been defined, and 0
> otherwise." So defined should be used with parenthesis, I think. At least
> most of Linux kernel source code is doing so. Ok?

And page 232 indicates that the brackets are not required (hey, I had
to check, too).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

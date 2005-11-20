Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVKTBeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVKTBeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVKTBeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:34:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751091AbVKTBeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:34:17 -0500
Date: Sat, 19 Nov 2005 17:33:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Message-Id: <20051119173358.2bf1dbb5.akpm@osdl.org>
In-Reply-To: <9a8748490511191715x61057bc8i1431ca3a24cfb2e6@mail.gmail.com>
References: <200511200010.33658.jesper.juhl@gmail.com>
	<20051119162805.47796de9.akpm@osdl.org>
	<9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
	<20051119170818.5e16afae.akpm@osdl.org>
	<9a8748490511191715x61057bc8i1431ca3a24cfb2e6@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Ok, so does that mean that, if properly verified, patches for things
>  that "gcc -Wsigned-compare" flags will be appreciated?

All patches are appreciated, but not all are applied ;)

Sure, go for it - let's see what the patches end up looking like.  We might
find real bugs in there - I found a bunch of howlers back in 2.3.late. 
That was with `gcc -W' which turns on more than -Wsigned-compare.

Maybe you could prepare a quick overall summary first, see if you can work
out the overall scope of the problem and then we can take a look at that,
decide what bits to attack?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTEBSPx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTEBSPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:15:53 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:41118 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263062AbTEBSPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:15:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 May 2003 11:29:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Florian Weimer <fw@deneb.enyo.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <87llxp43ii.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.50.0305021126200.1904-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
 <Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
 <87llxp43ii.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Florian Weimer wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
> > Ingo, do you want protection against shell code injection ? Have the
> > kernel to assign random stack addresses to processes and they won't be
> > able to guess the stack pointer to place the jump.
>
> If your software is broken enough to have buffer overflow bugs, it's
> not entirely unlikely that it leaks the stack address as well (IIRC,
> BIND 8 did).

Leaking the stack address is not a problem in this case, since the next
run will be very->very->very likely different.



- Davide


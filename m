Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJ2T1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTJ2T1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:27:35 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:35500 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261152AbTJ2T1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:27:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 29 Oct 2003 11:27:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SiS ISA bridge IRQ routing on 2.6 ...
In-Reply-To: <3F9F4841.2040904@cyberone.com.au>
Message-ID: <Pine.LNX.4.56.0310291124230.973@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.56.0310281931510.933@bigblue.dev.mdolabs.com>
 <3F9F4841.2040904@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Nick Piggin wrote:

> >Linus, I saw that Marcelo merged Alan bits to fix the IRQ routing with the
> >newest SiS ISA bridges. To make it really short the ISA bridge inside the
> >SiS 85C503/5513 issue IRQ routing requests on 0x60, 0x61, 0x62 and 0x63
> >for the USB hosts and the current code does not handle them correctly.
> >2.6-test9 does not have those bits and the USB  subsystem won't work w/out
> >that. Did Alan ever posted the patch for 2.6? If yes, did you simply miss
> >it or you have a particular reason to not merge it?
> >I really would like to remove the SiS IRQ patch from my to-apply-2.6
> >folder :)
> >
>
> Alan thought I should put SiS IRQ routing on the must-fix list.
> Doesn't mean it has to go in before 2.6.0, but if its common
> hardware and its in 2.4 without problems its probably a good idea.

Alan did not like my approach, so I'll let him post to Linus his work. If
he doesn't I'll post mine. The solution is trivial though and it works for
me as long as for many users that google'd about SiS+USB and asked me the
patch.



- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSI0Kwy>; Fri, 27 Sep 2002 06:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSI0Kwy>; Fri, 27 Sep 2002 06:52:54 -0400
Received: from 62-190-200-218.pdu.pipex.net ([62.190.200.218]:33540 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261688AbSI0Kwy>; Fri, 27 Sep 2002 06:52:54 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209271106.g8RB6PDg000759@darkstar.example.net>
Subject: Re: Framebuffer still "EXPERIMENTAL"?
To: pommnitz@yahoo.com (=?iso-8859-1?q?Joerg=20Pommnitz?=)
Date: Fri, 27 Sep 2002 12:06:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020927070948.77241.qmail@web13307.mail.yahoo.com> from "=?iso-8859-1?q?Joerg=20Pommnitz?=" at Sep 27, 2002 09:09:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Listees,
> yesterday I compiled 2.5.38 for the first time and noticed that the
> framebuffer option is still marked "EXPERIMENTAL". Well, I know for sure
> that I used the VESA-FB 3 years ago to get X running on a strange laptop
> graphic chip, so it is at least that long available (actually I think it
> got introduced for the Sparc port somewhen in 1995??). 
> 
> I think it's about time to promote the framebuffer code to a full fledged
> kernel feature. Comments?

I've noticed a bug with it, but haven't had time to investigate more fully, infact it might not be a kernel bug, but I suspect that it is.  I don't usually use the framebuffer, (I prefer the standard text mode).

On a standard Slackware 8.1 install, (kernel 2.4.18), on a machine with an ATI graphics card, and with the framebuffer enabled, if you type clear, then fill the screen with text so that it scrolls, (e.g. do a find /), the top four lines where the penguin used to be do not scroll, they just keep the text that is originally put there.  If you press shift-pageup, and then shift-pagedown, it fixes it.

If anybody has got the time to look in to this, I'll post more details.

John.

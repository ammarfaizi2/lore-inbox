Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbTELXES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTELXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:04:18 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:40596 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262908AbTELXER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:04:17 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Fulghum <paulkf@microgate.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030512233151.B17227@flint.arm.linux.org.uk>
References: <1052775331.1995.49.camel@diemos>
	 <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
	 <20030512233151.B17227@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1052781365.1185.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 01:16:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 00:31, Russell King wrote:
> > Does this still happen with all the patches Russell King posted
> > that everyone else is ignoring ?
> 
> I'm in the process of putting the patch in my outgoing patch queue
> for Linus, otherwise we're not going to make any forward progress.

Well, your patches do work pretty well for me... I've been playing
extensively with PCMCIA today, mainly with my 3Com CardBus NIC which has
really strange TX slowdown problems, by plugging and unplugging it over
and over again, loading and unloading the 3c59x.ko module and so on. So
at least, we're making some progress.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198


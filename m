Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270920AbUJUTwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270920AbUJUTwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270812AbUJUTte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:49:34 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:2688 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S270845AbUJUThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:37:19 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Pavel Machek <pavel@ucw.cz>
Date: Thu, 21 Oct 2004 12:36:59 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <4177AD6B.8391.20F028B0@localhost>
In-reply-to: <20041020190846.GA21315@elf.ucw.cz>
References: <41763777.26324.1B3B684C@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> > Yes, but there is only a very small set of PC hardware features you need 
> > to implement, and most BIOS'es only look at those things for timing 
> > purposes. Unfortunately there is no standard for how BIOS'es do internal 
> > timing and delay loops, so we emulate them all (8253 timers, speaker 
> > ports and CMOS time/date support ;-).
> 
> Hmm, that does not seem that bad. Did you need to emulate interrupt
> controller, too? That one seemed most scary to me.

No. Only software interrupts. The BIOS never deals with hardware 
interrupts since there is no standard, reliable way to hook them from 
real mode so it never uses them ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVAUJMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVAUJMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 04:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVAUJMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 04:12:12 -0500
Received: from mail-gw1.york.ac.uk ([144.32.128.246]:57996 "EHLO
	mail-gw1.york.ac.uk") by vger.kernel.org with ESMTP id S261663AbVAUJMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 04:12:02 -0500
Subject: Re: 2.6.9 suspend-to-disk bug (during resume)
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050120145804.GJ476@openzaurus.ucw.cz>
References: <1106210882.7975.9.camel@linux.site>
	 <1106210985l.8224l.0l@linux>  <20050120145804.GJ476@openzaurus.ucw.cz>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 09:08:20 +0000
Message-Id: <1106298500.10018.2.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 15:58 +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 10 (level, low) -> IRQ 10
> > bad: scheduling while atomic!
> >  [<c030164e>] schedule+0x4be/0x570
> >  [<c011ce69>] call_console_drivers+0x79/0x110
> >  [<c0124817>] __mod_timer+0x177/0x190
> >  [<c0301b8a>] schedule_timeout+0x5a/0xb0
> >  [<c0293ed9>] 

> Try without preempt for an ugly workaround. 
Check.

> Also try to reproduce it
> on 2.6.11-rc1.
Looks the same.  I can send demsg output if required.

> 				Pavel
> 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWI0Ax2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWI0Ax2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWI0Ax2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:53:28 -0400
Received: from xenotime.net ([66.160.160.81]:60318 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932103AbWI0Ax0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:53:26 -0400
Date: Tue, 26 Sep 2006 17:54:40 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
 acpi_pm clocksource has been installed.
Message-Id: <20060926175440.bb88b130.rdunlap@xenotime.net>
In-Reply-To: <200609270236.58148.jesper.juhl@gmail.com>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	<20060926173347.04fd66dd.rdunlap@xenotime.net>
	<200609270236.58148.jesper.juhl@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 02:36:58 +0200 Jesper Juhl wrote:

> On Wednesday 27 September 2006 02:33, Randy Dunlap wrote:
> > On Wed, 27 Sep 2006 02:22:18 +0200 Jesper Juhl wrote:
> > 
> > > I get this in dmesg with 2.6.18-git6 :
> > >       a3:<6>Time: acpi_pm clocksource has been installed.
> > > 
> > > Looks like some printk() somewhere is not adding \n correctly after
> > > outputting a message priority or a message priority too much is
> > > used... I've not investigated where this happens, but just wanted to
> > > report it.
> > 
> > Hi,
> > How about posting (pasting) some of the message log before that?
> > 
> Sure, below is the entire dmesg output from this boot of the box 
> (including the line above) :

OK, would you boot with "initcall_debug" on the kernel command
line and post the relevant output again, please?

> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> EDAC MC: Ver: 2.0.1 Sep 27 2006
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Starting balanced_irq
> Using IPI Shortcut mode
> a3:<6>Time: acpi_pm clocksource has been installed.
> 1d, IRQ 18.

---
~Randy

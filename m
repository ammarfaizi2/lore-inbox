Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272836AbTHEPwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTHEPwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:52:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:9148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272836AbTHEPwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:52:07 -0400
Date: Tue, 5 Aug 2003 08:57:01 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] save/restore screen support for ACPI S3 sleep
In-Reply-To: <20030805091734.GE388@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308050856350.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Aug 2003, Pavel Machek wrote:

> Hi!
> 
> > > This way console should be correctly restored after S3...
> > > 
> > > [Prototype should be added to include/linux/suspend.h].
> > > 
> > > kernel/suspend.c part only moves code out of "SWSUSP_ONLY"
> > > section.
> > 
> > I moved this code to kernel/power/console.c and made it dependent on 
> > CONFIG_PM only. I also fixed up the breakage Andrew reported earlier and 
> > added prototypes to include/linux/suspend.h. Patch below for review (not 
> > directly applicable, as it's relative to the series).
> 
> Patch looks good, except that you should put some comment at begining
> of console.c. (GPL+copyrights+one line what this file is about). I
> guess that's trivial to fix up incrementally.

Sorry, missed that part. Will fix up. 


	-pat


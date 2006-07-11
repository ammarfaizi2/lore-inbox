Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWGKULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWGKULd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGKULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:11:33 -0400
Received: from ns.suse.de ([195.135.220.2]:33208 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750826AbWGKULc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:11:32 -0400
Date: Tue, 11 Jul 2006 22:11:31 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711201131.GB17653@suse.de>
References: <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com> <20060711191548.GA17585@suse.de> <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org> <44B3FE34.9000704@zytor.com> <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, Linus Torvalds wrote:

> 
> 
> On Tue, 11 Jul 2006, H. Peter Anvin wrote:
> > 
> > Does that mean "in kernel space", "in the kernel distribution" or "in memory
> > completely under the control by the kernel?"  That is really what this is
> > about.
> 
> I think it's all about kernel space.
> 
> Moving the default parsing to user space would add exactly _zero_ 
> advantage, and would add totally unnecessary complexity (ie now we need to 
> make sure that hotplug does it right - and the hotplug routines suddenly 
> change between the boot phase and the actual install).

It depends what the benefit for such a change is. I cant come up with a
good guess. Maybe someone should write a paper and present it at OLS.

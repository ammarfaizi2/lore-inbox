Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWGKT7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWGKT7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWGKT7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:59:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6312 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932128AbWGKT7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:59:41 -0400
Message-ID: <44B40320.40005@garzik.org>
Date: Tue, 11 Jul 2006 15:59:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Olaf Hering <olh@suse.de>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com> <20060711191548.GA17585@suse.de> <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org> <44B3FE34.9000704@zytor.com> <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 11 Jul 2006, H. Peter Anvin wrote:
>> Does that mean "in kernel space", "in the kernel distribution" or "in memory
>> completely under the control by the kernel?"  That is really what this is
>> about.
> 
> I think it's all about kernel space.
> 
> Moving the default parsing to user space would add exactly _zero_ 
> advantage, and would add totally unnecessary complexity (ie now we need to 
> make sure that hotplug does it right - and the hotplug routines suddenly 
> change between the boot phase and the actual install).

With LVM (default RHEL and Fedora installs encourage you in that 
direction) and EVMS (device mapper), these issues already exist.

Today's default install has "partition" parsing in both the kernel and 
userspace...  talk about complexity :)

	Jeff



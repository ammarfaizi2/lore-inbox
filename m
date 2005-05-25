Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVEYNCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVEYNCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVEYNCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:02:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262335AbVEYNC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:02:28 -0400
Date: Wed, 25 May 2005 15:01:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Prakash Punnoor <lists@punnoor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp and kernel 2.6.12-rc4 does not work
Message-ID: <20050525130123.GA1881@elf.ucw.cz>
References: <429353F8.5070404@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429353F8.5070404@punnoor.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 24-05-05 18:19:04, Prakash Punnoor wrote:
> Hi,
> 
> I haven't treid with an earlier kernel. I am using an Sony Vaio PCG-F8ß07K
> notebook and tried to suspend.
> 
> What goes wrong is, that the hd gets shut down before anything is written to it.
> 
> I see (leaving some details out):
> 
> Stopping task:========================|
> Freeing memory..done (40502 pages freed)
> swsusp: Need to copy 6953 pages
> swsusp: critical section/: done (6981 pages copied)
> ACPI: PCI Interrupt yadda yadda.. -> IRQ 9
> 
> and there it sits. Is it really just the problem, that the hd gets shut down
> too early? Is there an easy way to fix this?

Disk shutdown is normal, you have other problem. Try again with
minimal drivers.
								Pavel

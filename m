Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266865AbUBEVOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUBEVOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:14:25 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:59567 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266865AbUBEVOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:14:18 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 18:14:35 +0000
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net> <200402051517.37466.murilo_pontes@yahoo.com.br> <20040205203840.GA13114@ucw.cz>
In-Reply-To: <20040205203840.GA13114@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402051814.35648.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My motherboard is k7n2-delta-l from MSI, and my mouse is Logitech PS/2 Optical Mouse Whell,
512mb of ram, no swap partitions

Well, always which compiling large sources like kde-3.2 and using XFree86-4.3.0 in parallel,
this bug is appears several times. Maybe not related with disks DMA/apic/acpi/preempt/agp issues,

Near of isolate bug is on VM system(stress it, like compiling kde-3.2 with no swap partitions) or 
I2C/ACPI Thermal zone/ACPI fans. Both have related with input system?

With lower load I newer take is bug. Anyone take? 


Em Qui 05 Fev 2004 20:38, Vojtech Pavlik escreveu:
> On Thu, Feb 05, 2004 at 05:24:27PM +0000, Murilo Pontes wrote:
> > I have same problems since of 2.6.0, now I running 2.6.2 stock kernel
> > I run XFree86-4.3.0 and still with problems, anyone try XFree86-4.4.0 devel snapshots???
> > 
> > I try kernel with/without  preempty/acpi/apic make all possibilities, 
> > then may be error is not in kernel, but in XFree86-4.3.0 which not support big changes in input system
> > of 2.6.x, I tried compile XFree86 with linux-2.6.{0,1,2} kernel headers was 100% fail, sounds binary 
> > and source incompatibilites,  
> 
> Hey, guys, could you possibly try to figure out what your machines have
> in common? I've switched all my computers to PS/2 mice so that I have a
> bigger chance to reproduce the problem, but it is not happening on any
> of them.
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTKKVJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKKVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:09:23 -0500
Received: from codepoet.org ([166.70.99.138]:24734 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263788AbTKKVJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:09:22 -0500
Date: Tue, 11 Nov 2003 14:09:22 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Julien Oster <lkml-20031111@mc.frodoid.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A7N8X (Deluxe) Madness
Message-ID: <20031111210922.GA10102@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Julien Oster <lkml-20031111@mc.frodoid.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <frodoid.frodo.87r80eznz9.fsf@usenet.frodoid.org> <20031111200922.GA9276@codepoet.org> <frodoid.frodo.87k766zmak.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.87k766zmak.fsf@usenet.frodoid.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 11, 2003 at 09:24:03PM +0100, Julien Oster wrote:
> Erik Andersen <andersen@codepoet.org> writes:
> 
> Hello Erik,
> 
> >> I have an ASUS A7N8X Deluxe mainboard. Yeah, right, that thing causing
> >> serious trouble. I'm getting hard lockups all the time. No panic, no
> >> message, no sysrq, no blinking cursor in the framebuffer. Gone for good.
> 
> > Does it help if you go into the BIOS and set the IDE controller
> > to "Compatible Mode" rather than "Enhanced Mode"?
> 
> I'm sorry, but I just can't find that option... it's the newest BIOS
> version, however?

I have an ASUS mb with that option, but I just checked
your manual and it indeed does not have that option.
Anyway, the problem I had was that I had my SATA ports
as well as all usb devices sharing the same interrupt
and the resulting interrupt storm was easily seen by
watching /proc/interrupts

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

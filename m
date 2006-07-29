Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWG2TiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWG2TiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWG2TiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:38:14 -0400
Received: from mail.tmr.com ([64.65.253.246]:48868 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751289AbWG2TiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:38:13 -0400
Message-ID: <44CBB9F8.3050300@tmr.com>
Date: Sat, 29 Jul 2006 15:41:44 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net>
In-Reply-To: <44CA7738.4050102@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Hello all,
> 
> More and more devices these days come with some sort of GPIO interface, 
> and more and more drivers within the kernel could make use of a common 
> way of accessing pins on such an interface, not to mention userspace 
> apps. For example, we have the I2C, LED, and SPI subsystems that each 
> could drive a device that's actually connected to some GPIO pins somewhere.
> 
> I propose to develop a common way of registering and accessing GPIO pins 
> on various devices. Now I'm no hardware expert, but I do like to dabble 
> a bit and would love to see such a system be developed. Most people tend 
> to attach stuff like LCD displays to their parallel ports, but GPIOs are 
> much better suited to such a purpose than a parallel port. Some (out of 
> tree) drivers even emulate a parallel interface in order that userspace 
> software can be fooled to use the GPIO pins as a parallel port. In my 
> view, this is ugly.
> 
	...

> So, if anyone likes this idea and/or has some comments, please voice 
> your opinions! With a little guidance from the masters, I'm willing to 
> put the effort in to code such a system, but I'd really like to hear 
> what people involved both in the hardware side and software side of 
> GPIOs and the kernel have to say about such an interface.

I think it's interesting enough so that it's worth figuring how this 
would work with or replace the various interfaces you mentioned. I'm 
sure another discussion would take place at that point, before writing code.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

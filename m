Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbULLAR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbULLAR1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 19:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbULLAR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 19:17:27 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:51184
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262035AbULLARX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 19:17:23 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide-cd problem revisited - more brainpower needed
Date: Sun, 12 Dec 2004 00:17:22 +0000
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200412102132.41512.alan@chandlerfamily.org.uk> <1102720480.3271.79.camel@localhost.localdomain>
In-Reply-To: <1102720480.3271.79.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412120017.22249.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 December 2004 23:14, Alan Cox wrote:
> On Gwe, 2004-12-10 at 21:32, Alan Chandler wrote:
> > All the above output is a result of the command (as root) using linux
> > 2.6.10-rc2 (with acpi turned off to avoid that bug)·
>
> Is local apic enabled ?

I don't understand what you mean

>
> > So what do I do next?  Why would the hardware work this way - is it a bug
> > in the firmware?, is there a subtle timing problem causing interrupts to
> > re-enter... should I just junk the hardware and start again?  Help!
>
> A purely armwaving guess of the moment is that if the IRQ routing is
> confused over edge versus level trigger then you would see extra
> interrupts. Does the drive work in another PC (I forget if you tried
> that)

I am doing all this at home on a personal level, so I am somewhat restricted. 

My normal CDRW machine is an Athlon 2100+ running on an Elite K7S5A 
motherboard.

I have a server running Celeron 1.7G and PlatiniX (Intel 845 Chipset) 
motherboard.  I moved the CDRW over to it and tried it. I didn't have time to 
build a special version of the system for it, and its running debian sarge 
with 2.6.8.1.  It failed to work, the symptoms were similar but slightly 
different.

-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbULKATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbULKATw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbULKATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:19:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23002 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261883AbULKATh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:19:37 -0500
Subject: Re: ide-cd problem revisited - more brainpower needed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <200412102132.41512.alan@chandlerfamily.org.uk>
References: <200411201842.15091.alan@chandlerfamily.org.uk>
	 <200411232149.31701.alan@chandlerfamily.org.uk>
	 <200411300859.43422.alan@chandlerfamily.org.uk>
	 <200412102132.41512.alan@chandlerfamily.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1102720480.3271.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Dec 2004 23:14:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-10 at 21:32, Alan Chandler wrote:
> All the above output is a result of the command (as root) using linux 
> 2.6.10-rc2 (with acpi turned off to avoid that bug)·
> 

Is local apic enabled ?

> So what do I do next?  Why would the hardware work this way - is it a bug in 
> the firmware?, is there a subtle timing problem causing interrupts to 
> re-enter... should I just junk the hardware and start again?  Help!

A purely armwaving guess of the moment is that if the IRQ routing is
confused over edge versus level trigger then you would see extra
interrupts. Does the drive work in another PC (I forget if you tried
that)


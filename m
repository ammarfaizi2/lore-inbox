Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUAMTPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUAMTPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:15:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:28098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265595AbUAMTPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:15:34 -0500
Date: Tue, 13 Jan 2004 11:16:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm2
Message-Id: <20040113111639.60b681d2.akpm@osdl.org>
In-Reply-To: <400441BD.9020609@gmx.de>
References: <20040110014542.2acdb968.akpm@osdl.org>
	<4003F34E.5080508@gmx.de>
	<20040113095428.440762f7.akpm@osdl.org>
	<400441BD.9020609@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
>
> >>kernel: Badness in pci_find_subsys at drivers/pci/search.c:132
> >>
> >>Any ideas? Or do you need detailed kernel config and dmesg? I thought 
> >>you might have an idea which atch caused this... My and his system are 
> >>quite differnt. Major Common element seems only use of Athlon XP. He has 
> >>VIA KT based system and I have nforce2. I thought it might be APIC, but 
> >>I also got a lock up without APIC. (Though it seems more stable without 
> >>APIC.)
> > 
> > 
> > If you could send us the stack backtrace that would help.  Make sure that
> > you have CONFIG_KALLSYMS enabled.  If you have to type it by hand, just the
> > symbol names will suffice - leave out the hex numbers.
> 
> Sorry, I am a noob about such things. Above option is enabled in my 
> config, but I dunno how get the stack backtrace. Could you point to me 
> to something helpful?

When the kernel prints that `badness' message it then prints a stack
backtrace.  That's what we want.


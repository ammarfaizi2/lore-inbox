Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSJULIf>; Mon, 21 Oct 2002 07:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSJULIf>; Mon, 21 Oct 2002 07:08:35 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35507 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261318AbSJULIf>; Mon, 21 Oct 2002 07:08:35 -0400
Subject: Re: System lockup.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Leckey <bleckey@tpg.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB3442A.7050002@tpg.com.au>
References: <3DB3442A.7050002@tpg.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 12:30:18 +0100
Message-Id: <1035199818.27259.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 01:02, Bill Leckey wrote:
> I have a terminal server that's supporting up to 240 lines.  It's a 
> 2.4.17 kernel, and is running squid, and using the reiser file system to 
> store log files, squid cache and other data.  About every day or so, the 
> machine locks up.  The screen is blank, keyboard doesn't respond, the 
> serial console I set up shows no 'dying gasp' and there is nothing in 
> any of the system logs.
> 
> This doesn't appear to be related to load as it has happened both during 
> the busiest times and during the low times.
> 
> I'm still servicing interrupts from our serial devices (on IRQ 11), so 
> it seems interrupts are still happening.
> 
> Beyond this, however, I have no idea where to go from here.  If anyone 
> has any hints on what the problem might be, or even a way to gather more 
> information, I would be grateful.

Hardware details would be a useful starting point. Also if its
uniprocessor or SMP. Finally have you considered 2.4.19 as 2.4.17 does
have at least one known and fixed small PPP race. With 240 lines I guess
you might actually hit that


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131143AbRBPU32>; Fri, 16 Feb 2001 15:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131168AbRBPU3S>; Fri, 16 Feb 2001 15:29:18 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:40764 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131143AbRBPU3E>; Fri, 16 Feb 2001 15:29:04 -0500
Date: Fri, 16 Feb 2001 15:28:58 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: isapnp , 2.2.14 vs. 2.4.1 and awe_wave
Message-ID: <20010216152858.B2111@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010216121255.22971.qmail@web3802.mail.yahoo.com> <E14Tk5N-000320-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Tk5N-000320-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 16, 2001 at 12:34:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) said: 
> > Probing around with test code in awe_wave.c, it become clear to me
> > that the card was not being initialized properly by my isapnptools. 
> > Even more alarming was the fact that pnpdump would not see the SB card 
> > at all under 2.4.1, unless I used the -r option, but would show it 
> > just fine under 2.2.14.
> 
> Dont mix isapnp tools with a 2.4 kernel unless you disable ISA PnP support
> in the kernel. It needs to have one or the other do it, not both

Um, earlier he said:

>  Since I use isapnptools and did not compile in any kernel pnp support,

Bill

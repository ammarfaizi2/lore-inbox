Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129384AbRBPMfs>; Fri, 16 Feb 2001 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbRBPMfi>; Fri, 16 Feb 2001 07:35:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129384AbRBPMf1>; Fri, 16 Feb 2001 07:35:27 -0500
Subject: Re: isapnp , 2.2.14 vs. 2.4.1 and awe_wave
To: mikes1987@yahoo.com (Mike S.)
Date: Fri, 16 Feb 2001 12:34:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, isapnp@roestock.demon.co.uk, tiwai@suse.de,
        mr.shonk@dial.pipex.com
In-Reply-To: <20010216121255.22971.qmail@web3802.mail.yahoo.com> from "Mike S." at Feb 16, 2001 04:12:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Tk5N-000320-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probing around with test code in awe_wave.c, it become clear to me
> that the card was not being initialized properly by my isapnptools. 
> Even more alarming was the fact that pnpdump would not see the SB card 
> at all under 2.4.1, unless I used the -r option, but would show it 
> just fine under 2.2.14.

Dont mix isapnp tools with a 2.4 kernel unless you disable ISA PnP support
in the kernel. It needs to have one or the other do it, not both


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTHQW3B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271105AbTHQW3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:29:01 -0400
Received: from www.13thfloor.at ([212.16.59.250]:40921 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271104AbTHQW27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:28:59 -0400
Date: Mon, 18 Aug 2003 00:28:43 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
Message-ID: <20030817222843.GB10967@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030817212824.GA9025@www.13thfloor.at> <20030817221114.GA734@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030817221114.GA734@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:11:14AM +0200, Willy Tarreau wrote:
> On Sun, Aug 17, 2003 at 11:28:24PM +0200, Herbert P?tzl wrote:
> > 
> > Hi All!
> > 
> > Still no nmi_watchdog on dual Athlon systems?
> 
> Hi !
> 
> mine works fine only with nmi_watchdog=2. Don't know why. 
> It's an ASUS A7M266D.

hmm, nmi_watchdog=2 on the kernel boot line gives no
difference to booting without, at least according to
the boot messages ...

ENABLING IO-APIC IRQs                                                                       
..TIMER: vector=0x31 pin1=2 pin2=0                                                          
testing the IO APIC.......................                                                  
                                                                                            
.................................... done.                                                  
Using local APIC timer interrupts.                                                          
calibrating APIC timer ...                                                                  
..... CPU clock speed is 1533.4487 MHz.                                                     

maybe the nmi_watchdog is always enabled? 
maybe it only fails with nmi_watchdog=1 ?
shouldn't there be a message which says that
the NMI watchdog was enabled?

TIA,
Herbert

> Cheers,
> Willy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbRERNhd>; Fri, 18 May 2001 09:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262315AbRERNhX>; Fri, 18 May 2001 09:37:23 -0400
Received: from [142.176.139.106] ([142.176.139.106]:28170 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S262312AbRERNhJ>;
	Fri, 18 May 2001 09:37:09 -0400
Date: Fri, 18 May 2001 10:37:05 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 - kernel 2.4.3
In-Reply-To: <Pine.LNX.4.21.0105181328560.11038-100000@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.21.0105181036320.8552-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yup!   Mine was ok too with the 2.4.2 kernel. So something has changed
from 2.4.3 and up. Hmmmmmm??


On Fri, 18 May 2001, Martin Josefsson wrote:

> Date: Fri, 18 May 2001 13:31:56 +0200 (CEST)
> From: Martin Josefsson <gandalf@wlug.westbo.se>
> To: Ted Gervais <ve1drg@ve1drg.com>
> Subject: Re: rtl8139 - kernel 2.4.3
> 
> On Thu, 17 May 2001, Ted Gervais wrote:
> 
> > 
> > I get the following when ftping from one workstation to another.
> > Using kernel 2.4.3 and Redhat7.1:
> > 
> > Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> > Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> > Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> > Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> > Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> > Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> > eth0: Out-of-sync dirty pointer, 456 vs. 462.
> > Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> > Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> > Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> > Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> > 
> > 
> > Is there a fix for this?  Kernel 2.4.4 is worse. It gives me a 'kernel
> > panic'..  doing the same ftp transfer between workstations.
> 
> I think I suffer from the same problem. The machine was stable with
> 2.4.2-ac6 until I started playing with smbfs and hit a bug in that. 
> So I upgraded to 2.4.4 and since then the machine has been very unstable.
> Maximum uptime so far is 4 days and then it fell over.
> And I'm using an rtl8139 card too.
> 
> I don't have a monitor attached to the machine but I'm compiling
> 2.4.4-ac10 (afraid of the LVM changes in -ac11) with the kmsgdump patch so
> I'll probably get a stackdump sometime later today.
> 
> /Martin
> 

---
The mosquito is the state bird of New Jersey.
                -- Andy Warhol
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbRDMEFG>; Fri, 13 Apr 2001 00:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135396AbRDMEE4>; Fri, 13 Apr 2001 00:04:56 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:19718
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135395AbRDMEEw>; Fri, 13 Apr 2001 00:04:52 -0400
Date: Thu, 12 Apr 2001 21:04:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: george anzinger <george@mvista.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <3AD66B62.23620639@mvista.com>
Message-ID: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, george anzinger wrote:

> Actually we could do the same thing they did for errno, i.e.
> 
> #define jiffies get_jiffies()
> extern unsigned get_jiffies(void);

> No, not really.  HZ still defines the units of jiffies and most all the
> timing is still related to it.  Its just that interrupts are only "set
> up" when a "real" time event is due.

Great HZ always defines units of jiffies, but that is worthless if there
is not a ruleset that tells me a value to divide by to return it to a
specific quantity of time.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com


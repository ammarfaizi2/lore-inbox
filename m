Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283651AbRK3NZ3>; Fri, 30 Nov 2001 08:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283652AbRK3NZT>; Fri, 30 Nov 2001 08:25:19 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:11717 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283651AbRK3NZD>; Fri, 30 Nov 2001 08:25:03 -0500
Date: Fri, 30 Nov 2001 15:30:04 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <miquels@cistron-office.nl>
Subject: Re: XT-PIC vs IO-APIC and PCI devices
In-Reply-To: <Pine.GSO.3.96.1011130140806.15249K-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0111301527010.24304-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Maciej W. Rozycki wrote:

>  Do you have sources for the driver?  Last time I looked at the driver, it
> was binary-only (the distribution contained a copy of the GNU GPL, yet the
> vendor refused to release sources I asked for) and it seemed to be broken
> horribly.  Be happy at least it works for you with interrupts routed
> through the 8259A.

Nope they provide some source as "glue" and do the final linking
against some object files. I've been hacking on the glue code, so far
i've managed to get multiple card detection working and with some
help removed some races but who knows what lurks in those .o's.

Cheers,
	Zwane Mwaikambo



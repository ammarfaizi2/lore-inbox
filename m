Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSHBRAx>; Fri, 2 Aug 2002 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSHBRAw>; Fri, 2 Aug 2002 13:00:52 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:53724 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S316210AbSHBRAw>;
	Fri, 2 Aug 2002 13:00:52 -0400
Date: Fri, 2 Aug 2002 11:57:44 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <1028290998.18309.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208021154380.29253-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Aug 2002, Alan Cox wrote:

> On Fri, 2002-08-02 at 04:17, Linus Torvalds wrote:
> > If the PNP BIOS panic is new (ie it didn't happen in 2.5.24), can you
> > write down the whole panic (and look up the symbols) and send that one to
> > Ingo Molnar <mingo@elte.hu>?
> > 
> > That would most likely be due to some of the GDT reorganizations that
> > happened for 2.5.30 due to the thread-local-storage patches.
> 
> The PnPBIOS gdt setup changes I did are wrong somewhere. If I can get
> 2.5.30 to actually boot I'll try and track it down. The traces I have
> basically go 
> 	kernel -> kernel -> kernel -> pnpbios *BANG*
> 
> and appear to be jumping to the wrong physical address (ie gdt is
> incorrect)

I have an open problem report on pnpbios, together with an oops, on 
my status report page at http://members.cox.net/kernprobs/status.html 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTL3ASC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTL3ASB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:18:01 -0500
Received: from [24.35.117.106] ([24.35.117.106]:32650 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262048AbTL3ASA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:18:00 -0500
Date: Mon, 29 Dec 2003 19:17:23 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Martin Schlemmer <azarah@nosferatu.za.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <1072741422.25741.67.camel@nosferatu.lan>
Message-ID: <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> 
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> 
 <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
 <1072741422.25741.67.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Martin Schlemmer wrote:

> >  UDMA modes: udma0 udma1 *udma2 udma3 udma4
> >  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
> >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
> > 
> >  * signifies the current active mode
> 
> Any reason it is currently set to udma2 where it support udma4 ?

Not really.  The question was what mode the disk was running in.  This is 
what it defaults to.  This is a laptop drive that only runs at 5400RPM.  
Would changing the mode to udma4 make a dramatic difference?  

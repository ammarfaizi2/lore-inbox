Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFOQae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFOQae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 12:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFOQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 12:30:34 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42510 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261210AbVFOQa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:30:27 -0400
Date: Wed, 15 Jun 2005 17:29:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: 7eggert@gmx.de, Gene Heskett <gene.heskett@verizon.net>,
       cutaway@bellsouth.net, linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <Pine.LNX.4.61.0506151200490.24211@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61L.0506151723460.13835@blysk.ds.pg.gda.pl>
References: <4fB8l-73q-9@gated-at.bofh.it> <4fF2j-1Lo-19@gated-at.bofh.it>
 <E1DiZKe-0000em-58@be1.7eggert.dyndns.org> <Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.61.0506151200490.24211@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Richard B. Johnson wrote:

> Well the __documented__ '486 LEA instruction doesn't
> even allow the double-register indirect. It's just
> 
> LEA r16,m
> LEA r32,m
> 
> ... repeated twice
> 
> Page 26-190,  Intel486(tm) Microprocessor Programmer's Reference
> Manual. ISBN 1-55512-195-4. The instruction may have been one
> of those "immature features", read broken.

 And "m" is presumably described in details elsewhere as the semantics is 
common for all instructions involving address calculation.  There is no 
point in repeating the lengthy explanation for every instruction, is it?  
Or would you prefer having each possible register and/or value of constant 
arguments described for every instruction separately?

  Maciej

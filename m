Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWF2JVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWF2JVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWF2JVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:21:38 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:62646 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751694AbWF2JVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:21:37 -0400
Date: Thu, 29 Jun 2006 05:21:34 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Milan Svoboda <msvoboda@ra.rockwell.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <Pine.LNX.4.64.0606291051400.10401@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606290517420.25758@gandalf.stny.rr.com>
References: <OF333B3CA3.DCE515CC-ONC125719C.00265C3B-C125719C.0026A1E2@ra.rockwell.com>
 <Pine.LNX.4.64.0606291051400.10401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2006, Esben Nielsen wrote:

> On Thu, 29 Jun 2006, Milan Svoboda wrote:
> >
> > I use "old" eepro100 network device driver...
> >

Why?  Do you have problems with the e100 driver?  Just to let you know
that the eepro100 is scheduled for removal:

http://marc.theaimsgroup.com/?l=git-commits-head&m=114288220325419&w=2


>
> "old"?

>
> > Thank you for your answer, I look at it too...
> >
>
> eepro100 seems to be SMP safe, so it shouldn't be there.
> Have anyone else used eepro100 with preempt-realtime?

I use to use it a while back ago, when e100 would screw up my network
card. But that has been fixed so I don't use eepro100 and I would
recommend anyone else to switch to e100.

-- Steve


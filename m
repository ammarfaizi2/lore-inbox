Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWI2FS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWI2FS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 01:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWI2FS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 01:18:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750922AbWI2FS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 01:18:56 -0400
Date: Thu, 28 Sep 2006 22:16:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: "Greg KH" <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>, jgarzik@pobox.com
Subject: Re: 2.6.18-mm2 -- EIP: [<c11a962e>] klist_node_init+0x2b/0x3a
 SS:ESP 0068:f63a5f80
Message-Id: <20060928221648.cbeb6889.akpm@osdl.org>
In-Reply-To: <a44ae5cd0609282204p4f09da52n44124a2bee05b85c@mail.gmail.com>
References: <a44ae5cd0609281913q127abc03i72dc7ea8711a223f@mail.gmail.com>
	<20060928200431.8f7f3fea.akpm@osdl.org>
	<a44ae5cd0609282131t2841a7b7ued9ffc22ac470687@mail.gmail.com>
	<20060928214910.a3be37ea.akpm@osdl.org>
	<a44ae5cd0609282204p4f09da52n44124a2bee05b85c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 22:04:00 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> > > but either ipw2200 or
> > > NetworkManager is still not working.  I am running Fedora development
> > > (rawhide).  For some reason, NM still cannot establish a connection
> > > with this kernel build (this failed with 2.6.18-mm2 previously, but I
> > > thought it was related to the BUG).  "iwlist scan" can corrently
> > > detect my access point.  Also, I can use iwconfig and dhclient to
> > > establish a working connection.  NM fails with this output in the
> > > message log (I'll try getting a more detailed debug log out of NM):
> >
> > Another reporter mentioned that he could only get his wireless to associate
> > with his AP by using essid "any".  But that was a different type of card.
> >
> > ipw2200 works OK for me, fwiw.
> 
> Shall I send you my .config?

argh.  I'm afraid my head pointer keeps on wrapping past my tail pointer
recently.

But what the heck, yes please.  I'm sure James will appreciate it ;)

> > There's a largeish ipw2200 update in mainline now.  That'd be worth testing.
> >
> > It looks like that ipw2200 update was in 2.6.18-mm1 though.  Did that work?
> 
> Yes, it did.  My main problem with mm1 was the broken CPUFreq, which
> is still busted in mm2.

Oh.  Is anyone looking into that?

>  I am rebuilding with debugging enabled in the
> ipw2200 driver.  I'll see if I can capture any useful information when
> I try to associate using NM.

Testing mainline would be useful.

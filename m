Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVLaBPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVLaBPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVLaBPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:15:33 -0500
Received: from hera.kernel.org ([140.211.167.34]:43686 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932070AbVLaBPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:15:33 -0500
Date: Fri, 30 Dec 2005 19:13:40 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andreas Kleen <ak@suse.de>, Denis Vlasenko <vda@ilport.com.ua>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051230211340.GA3672@dmt.cnet>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua> <200512281054.26703.vda@ilport.com.ua> <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <20051228210124.GB1639@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228210124.GB1639@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<snip>

> > Note that just looking at slabinfo is not enough for this - you need the
> > original
> > sizes as passed to kmalloc, not the rounded values reported there.
> > Should be probably not too hard to hack a simple monitoring script up
> > for that
> > in systemtap to generate the data.
> 
> Something like this:
> 
> http://lwn.net/Articles/124374/

Written with a systemtap script: 
http://sourceware.org/ml/systemtap/2005-q3/msg00550.html


